// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, deprecated_member_use, missing_return

import 'dart:io';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/main/home.dart';
import 'package:app_55hz/presentation/login/login_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../login/email_check.dart';
import '../login/registration.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  AdInterstitial adInterstitial;

  @override
  Login({Key key, this.adInterstitial}) : super(key: key);

  GoogleSignInAccount googleUser;
  GoogleSignInAuthentication googleAuth;
  AuthCredential credential;

  String login_Email = ""; // 入力されたメールアドレス
  String login_Password = ""; // 入力されたパスワード

  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId,
    request: const AdRequest(),
  )..load();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
        value: LoginModel(),
        child: Consumer<LoginModel>(builder: (context, model, child) {
          return Scaffold(
            backgroundColor: const Color(0xffFCFAF2),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
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
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.5,
                            height: size.width * 0.5,
                            child: Transform.rotate(
                              angle: 23.4 * pi / 180,
                              child: const Image(
                                image: AssetImage('images/logo.png'),
                              ),
                            ),
                          ),
                        ),

                        // メールアドレスの入力フォーム
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "メールアドレス"),
                              onChanged: (String value) {
                                login_Email = value;
                              },
                            )),

                        // パスワードの入力フォーム
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: "パスワード（8～20文字）"),
                            obscureText: true, // パスワードが見えないようRにする
                            maxLength: 20, // 入力可能な文字数
                            onChanged: (String value) {
                              login_Password = value;
                            },
                          ),
                        ),

                        // ログイン失敗時のエラーメッセージ
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                          child: Text(
                            model.infoText,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                        // ログインボタンの配置
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonTheme(
                              minWidth: size.width * 0.45,
                              // height: 100.0,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      primary: Colors.blue[50]),

                                  // ボタンクリック後にアカウント作成用の画面の遷移する。
                                  onPressed: () {
                                    if (model.ischeckedAgree == true) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) =>
                                              const Registration(),
                                        ),
                                      );
                                    } else {
                                      agreeDialog(context, model);
                                    }
                                  },
                                  child: const Text(
                                    'アカウントを作成する',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  )),
                            ),
                            ButtonTheme(
                              minWidth: size.width * 0.45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: const Color(0xff39bdcc),
                                ),

                                onPressed: () async {
                                  if (model.ischeckedAgree == true) {
                                    try {
                                      // メール/パスワードでログイン
                                      model.result = await model.auth
                                          .signInWithEmailAndPassword(
                                        email: login_Email,
                                        password: login_Password,
                                      );
                                      final isFirstLogin = model
                                          .result.additionalUserInfo.isNewUser;

                                      // ログイン成功
                                      model.user =
                                          model.result.user; // ログインユーザーのIDを取得

                                      // Email確認が済んでいる場合のみHome画面へ
                                      if (isFirstLogin) {
                                        if (model.user.emailVerified) {
                                          await model
                                              .createUserDatabase(model.user);
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Home(
                                                  auth: model.auth,
                                                  uid: model.user.uid,
                                                  adInterstitial:
                                                      adInterstitial,
                                                ),
                                              ));
                                        } else {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Emailcheck(
                                                      email: login_Email,
                                                      pswd: login_Password,
                                                      from: 2,
                                                      adInterstitial:
                                                          adInterstitial,
                                                    )),
                                          );
                                        }
                                      } else {
                                        if (model.user.emailVerified) {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Home(
                                                  auth: model.auth,
                                                  uid: model.user.uid,
                                                  adInterstitial:
                                                      adInterstitial,
                                                ),
                                              ));
                                        } else {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Emailcheck(
                                                      email: login_Email,
                                                      pswd: login_Password,
                                                      from: 2,
                                                      adInterstitial:
                                                          adInterstitial,
                                                    )),
                                          );
                                        }
                                      }
                                    } catch (e) {
                                      // ログインに失敗した場合
                                      model.loginErrorMessage(e);
                                    }
                                  } else {
                                    await agreeDialog(context, model);
                                  }
                                },

                                // ボタン内の文字や書式
                                child: const Text(
                                  'ログイン',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // ログイン失敗時のエラーメッセージ
                        TextButton(
                          child: const Text('上記メールアドレスにパスワード再設定メールを送信'),
                          onPressed: () => model.auth
                              .sendPasswordResetEmail(email: login_Email),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SignInButton.mini(
                              buttonType: ButtonType.google,
                              onPressed: () async {
                                if (model.ischeckedAgree == true) {
                                  googleUser = await GoogleSignIn().signIn();
                                  googleAuth = await googleUser.authentication;
                                  credential = GoogleAuthProvider.credential(
                                    accessToken: googleAuth.accessToken,
                                    idToken: googleAuth.idToken,
                                  );
                                  try {
                                    final result = await model.auth
                                        .signInWithCredential(credential);
                                    final isFirstLogin =
                                        result.additionalUserInfo.isNewUser;
                                    if (isFirstLogin) {
                                      final user = result.user;
                                      await model.createUserDatabase(user);
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(
                                              auth: model.auth,
                                              uid: user.uid,
                                            ),
                                          ));
                                    } else {
                                      final user = result.user;
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(
                                              auth: model.auth,
                                              uid: user.uid,
                                              adInterstitial: adInterstitial,
                                            ),
                                          ));
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  await agreeDialog(context, model);
                                }
                              },
                            ),
                            Platform.isIOS
                                ? SignInButton.mini(
                                    buttonType: ButtonType.apple,
                                    onPressed: () async {
                                      if (model.ischeckedAgree == true) {
                                        final appleIdCredential =
                                            await SignInWithApple
                                                .getAppleIDCredential(
                                          scopes: [
                                            AppleIDAuthorizationScopes.email,
                                            AppleIDAuthorizationScopes.fullName,
                                          ],
                                        );
                                        final oAuthProvider =
                                            OAuthProvider('apple.com');
                                        final credential =
                                            oAuthProvider.credential(
                                          idToken:
                                              appleIdCredential.identityToken,
                                          accessToken: appleIdCredential
                                              .authorizationCode,
                                        );
                                        try {
                                          final result = await model.auth
                                              .signInWithCredential(credential);
                                          final isFirstLogin = result
                                              .additionalUserInfo.isNewUser;
                                          if (isFirstLogin) {
                                            final user = result.user;
                                            await model
                                                .createUserDatabase(user);
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Home(
                                                    auth: model.auth,
                                                    uid: user.uid,
                                                  ),
                                                ));
                                          } else {
                                            final user = result.user;
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Home(
                                                    auth: model.auth,
                                                    uid: user.uid,
                                                    adInterstitial:
                                                        adInterstitial,
                                                  ),
                                                ));
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      } else {
                                        await agreeDialog(context, model);
                                      }
                                    })
                                : const SizedBox()
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(
                                  text: '使用前に必ず\n ',
                                ),
                                TextSpan(
                                    text: '利用規約・プライバシーポリシー',
                                    style: const TextStyle(
                                        color: Colors.blue, fontSize: 15),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await model.lunchTermsOfService();
                                        await model.readAgree();
                                      }),
                                const TextSpan(text: 'に同意してください')
                              ]),
                        ),
                        const SizedBox(height: 20),

                        model.isreadAgree == true
                            ? model.ischeckedAgree == true
                                ? const SizedBox()
                                : ElevatedButton(
                                    onPressed: () async {
                                      await agreeCheckDialog(context, model);
                                    },
                                    child: const Text('利用規約・プライバシーポリシーに同意します'))
                            : ElevatedButton(
                                onPressed: () {
                                  agreeDialog(context, model);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey, //ボタンの背景色
                                ),
                                child: const Text(
                                  '利用規約・プライバシーポリシーに同意します',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: 64,
              child: AdWidget(
                ad: banner,
              ),
            ),
          );
        }));
  }

  Future agreeDialog(BuildContext context, LoginModel model) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("利用規約・プライバシーポリシーを最後までお読みになって同意してください"),
          actions: [
            TextButton(
                child: const Text("OK"),
                onPressed: () async {
                  model.readAgree();
                  model.lunchTermsOfService();
                  Navigator.pop(context);
                }),
            const SizedBox(width: 20),
          ],
        );
      },
    );
  }

  Future agreeCheckDialog(BuildContext context, LoginModel model) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("利用規約・プライバシーポリシーに同意しますか？"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    child: const Text("NO"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                      model.checkedAgree();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }

  Future errorDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('エラーが発生しましたもう一度お試しください',
              style:
                  GoogleFonts.sawarabiMincho(color: const Color(0xffFCFAF2))),
          actions: [
            TextButton(
              child: const Text('閉じる'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
