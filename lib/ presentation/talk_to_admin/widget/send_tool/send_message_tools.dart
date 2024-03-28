import 'package:app_55hz/%20presentation/add_talk/provider/pick_image_provider.dart';
import 'package:app_55hz/%20presentation/add_talk/widget/image_widget/picked_image_9ch.dart';
import 'package:app_55hz/%20presentation/edit_profile/provider/my_name_provider.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/provider/talk_to_admin_list_provider.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/widget/send_tool/select_picture_button.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/widget/send_tool/send_message_button.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendMessageTools extends HookConsumerWidget {
  const SendMessageTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = useState('');
    final messageController = useTextEditingController();
    final image = ref.watch(pickImageProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image != null ? PickedImage9ch(image: image) : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SelectPictureButton(),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextFormField(
                    maxLines: 10,
                    minLines: 1,
                    onChanged: (value) {
                      message.value = value;
                    },
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Aa',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      fillColor: const Color(0xFFF0F0F0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                )),
                SendMessageButton(
                  onTap: message.value.trim().isEmpty && image == null
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          final name = await ref.read(myNameProvider.future);
                          final talk = Talk(
                              createdAt: DateTime.now(),
                              comment: message.value,
                              badCount: [],
                              imgURL: '',
                              name: name);
                          messageController.text = '';
                          message.value = '';
                          await ref
                              .read(talkToAdminListProvider.notifier)
                              .addTalk(talk, image);
                        },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
