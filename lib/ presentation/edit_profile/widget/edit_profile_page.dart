import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/edit_profile/provider/my_name_provider.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final name = ref.watch(myNameProvider).when(
        data: (data) {
          return data!;
        },
        error: (__, _) => __.toString(),
        loading: () => '');
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集',
            style: TextStyle(color: Color(0xffFCFAF2), fontSize: 25.0)),
        backgroundColor: const Color(0xff616138),
        flexibleSpace: const AppBarBackImg(
          color: Color(0xff616138),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const BackImg(),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const BannerWidget(adSize: AdSize.fullBanner),
                  const LogoImage(),
                  const Text('あなたのハンドルネームは',
                      style: TextStyle(color: Color(0xff43341B), fontSize: 25)),
                  const SizedBox(height: 48),
                  SizedBox(
                      child: Text(name,
                          style: const TextStyle(
                              color: Color(0xff43341B),
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                  style: const TextStyle(
                                      color: Color(0xff43341B),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  controller: nameController,
                                  maxLength: 20,
                                  decoration: InputDecoration(
                                      labelText: '新しいハンドルネームを入力',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xff43341B)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                              color: Color(0xff33A6B8)))))))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0C4842)),
                      onPressed: () async {
                        if (nameController.text == '') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('名前を入力してください'),
                                  content: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('閉じる')),
                                );
                              });
                        } else {
                          ref
                              .read(myNameProvider.notifier)
                              .changeHandleName(nameController.text);
                          nameController.clear();
                        }
                      },
                      child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('変更確定',
                              style: TextStyle(
                                  color: Color(0xffFCFAF2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
