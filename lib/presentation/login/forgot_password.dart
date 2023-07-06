// ignore: unused_import
import 'package:app_55hz/presentation/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

TextEditingController emailController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  ForgotPassword();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
        value: LoginModel(),
        child: Consumer<LoginModel>(builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text('パスワードを忘れた方',
                    style: GoogleFonts.sawarabiMincho(
                        color: const Color(0xffFCFAF2))),
                flexibleSpace: const Image(
                  image: AssetImage('images/washi1.png'),
                  fit: BoxFit.cover,
                  color: Color(0xff616138),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: size.width * 0.8,
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                ),
                                label: Text(
                                  'メールアドレス',
                                  style: TextStyle(fontSize: 18),
                                )),
                            onChanged: (value) {
                              model.email = value;
                            },
                          ),
                        ),
                      ),
                      TextButton(
                        child: const Text('上記メールアドレスにパスワード再設定メールを送信'),
                        onPressed: () => model.auth
                            .sendPasswordResetEmail(email: model.email),
                      ),
                    ],
                  ),
                ],
              ));
        }));
  }
}
