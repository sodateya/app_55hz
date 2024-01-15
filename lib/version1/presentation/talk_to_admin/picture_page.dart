// ignore_for_file: must_be_immutable, missing_return, use_build_context_synchronously

import 'dart:io';

import 'package:app_55hz/version1/presentation/talk_to_admin/talk_to_admin_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//File imageFile;

class PicturePage extends StatelessWidget {
  PicturePage({
    super.key,
    required this.ontap,
    required this.imageFile,
    required this.size,
  });

  final AsyncCallback ontap;
  File imageFile;
  Size size;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TalkToAdminModel>(
        create: (context) => TalkToAdminModel(),
        child: Consumer<TalkToAdminModel>(builder: (context, model, child) {
          model.imageFile = imageFile;
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: IconButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 35,
                      )),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: size.width - 250,
                        minHeight: size.height - 250),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        imageFile,
                      ),
                    ),
                  ),
                ),
                model.isLoading == true
                    ? Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 300,
                          height: 300,
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.square(),
              ],
            ),
            floatingActionButton: model.isLoading == false
                ? FloatingActionButton(
                    child: const Icon(Icons.send),
                    onPressed: () async {
                      try {
                        model.startLoading();
                        ontap();
                        // await model.addImage(roomID, uid);
                      } catch (e) {
                        print(e);
                      } finally {
                        model.endLoading();
                      }
                      model.imageFile = null;
                      Navigator.of(context).pop();
                    },
                  )
                : const SizedBox.square(),
          );
        }));
  }
}
