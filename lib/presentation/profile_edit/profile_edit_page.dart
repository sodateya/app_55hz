import 'dart:math';

import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/profile_edit/profile_edit_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfileEditPage extends StatelessWidget {
  String uid;
  AdInterstitial adInterstitial;
  bool isChanged;
  ProfileEditPage({
    Key key,
    this.uid,
  }) : super(key: key);
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: ProfileEditModel()..getName(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/washi1.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0xff616138),
                    BlendMode.modulate,
                  ),
                ),
              ),
            ),
            title: const Text(
              'プロフィール編集',
              style: TextStyle(
                color: Color(0xffFCFAF2),
                fontSize: 25.0,
              ),
            ),
            backgroundColor: const Color(0xff616138),
          ),
          backgroundColor: const Color(0xffFCFAF2),
          body: Consumer<ProfileEditModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      const Color(0xffFCFAF2).withOpacity(0.4),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage('images/washi1.png'),
                    fit: BoxFit.fill,
                  )),
                ),
                SizedBox(
                  width: size.width,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Transform.rotate(
                            angle: 23.4 * pi / 180,
                            child: const Image(
                              image: AssetImage('images/logo.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'あなたのハンドルネームは',
                          style: TextStyle(
                            color: Color(0xff43341B),
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Text(
                            model.handleName ?? '',
                            style: const TextStyle(
                                color: Color(0xff43341B),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: size.width * 0.8,
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
                                            color: Color(0xff33A6B8)),
                                      )))),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff0C4842),
                            ),
                            onPressed: () async {
                              await setName(model, context);
                            },
                            child: const Text(
                              '変更確定',
                              style: TextStyle(
                                  color: Color(0xffFCFAF2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future setName(ProfileEditModel model, BuildContext context) async {
    try {
      await model.setName(nameController.text);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ハンドルネームを変更しました'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      final snackBar = SnackBar(
        backgroundColor: const Color(0xffD0104C),
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
