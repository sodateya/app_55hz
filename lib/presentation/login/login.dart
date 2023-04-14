// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/main/home.dart';
import 'package:app_55hz/presentation/login/forgot_password.dart';
import 'package:app_55hz/presentation/login/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

import 'email_check.dart';

import 'login_model.dart';

class Login extends StatelessWidget {
  AdInterstitial adInterstitial;
  GoogleSignInAccount googleUser;
  GoogleSignInAuthentication googleAuth;
  AuthCredential credential;

  Login({Key key, this.adInterstitial}) : super(key: key);

  String login_Email = ""; // 入力されたメールアドレス
  String login_Password = "";
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId,
    request: const AdRequest(),
  )..load();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: LoginModel(),
        child: Consumer<LoginModel>(builder: (context, model, child) {
          return Scaffold(
              body: Stack(
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
                      ))),
                  GestureDetector(
                    onTap: () {
                      primaryFocus?.unfocus();
                    },
                    child: SingleChildScrollView(
                      child: SafeArea(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 30),

                                Container(
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset('images/logo.png')),

                                // メールアドレスの入力フォーム

                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                    ),
                                    labelText: 'メールアドレス',
                                  ),
                                  onChanged: (String value) {
                                    login_Email = value;
                                  },
                                ),
                                const SizedBox(height: 24),
                                TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(fontSize: 12),
                                    labelText: 'パスワード',
                                  ),
                                  onChanged: (String value) {
                                    login_Password = value;
                                  },
                                ),
                                const SizedBox(height: 24),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0, 20.0, 5.0),
                                  child: Text(
                                    model.infoText,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: model.agreeToTerms,
                                        onChanged: (value) {
                                          if (model.readTerms == false) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        '利用規約をお読みになってから同意してください'),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  '閉じる')),
                                                          TextButton(
                                                              onPressed: () {
                                                                launchUrl(
                                                                  Uri.parse(
                                                                      'https://hz-360fa.web.app/'),
                                                                );
                                                                model
                                                                    .isReadTerms(
                                                                        true);
                                                                model
                                                                    .isAgreeToTerms(
                                                                        value);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  '利用規約を読む'))
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                });
                                          } else {
                                            model.isAgreeToTerms(value);
                                          }
                                        },
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          launchUrl(
                                            Uri.parse(
                                                'https://hz-360fa.web.app/'),
                                          );
                                          model.isReadTerms(true);
                                        },
                                        child: Text('ご利用規約',
                                            style: GoogleFonts.sawarabiMincho(
                                                color: const Color(0xff33A6B8),
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    clipBehavior: Clip.antiAlias,
                                    onPressed: model.agreeToTerms == false
                                        ? null
                                        : () async {
                                            try {
                                              // メール/パスワードでログイン
                                              model.result = await model.auth
                                                  .signInWithEmailAndPassword(
                                                email: login_Email,
                                                password: login_Password,
                                              );
                                              // ログイン成功
                                              model.user = model.result
                                                  .user; // ログインユーザーのIDを取得

                                              if (model.user.emailVerified) {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home(
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
                                                            pswd:
                                                                login_Password,
                                                            from: 2,
                                                          )),
                                                );
                                              }
                                            } catch (e) {
                                              print(e);
                                              // ログインに失敗した場合
                                              model.loginErrorMessage(e);
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: const Color(0xff33A6B8)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 15,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text('メールログイン',
                                              style: GoogleFonts.sawarabiMincho(
                                                  color:
                                                      const Color(0xff43341B))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    clipBehavior: Clip.antiAlias,
                                    onPressed: model.agreeToTerms == false
                                        ? null
                                        : () async {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                fullscreenDialog: true,
                                                builder:
                                                    (BuildContext context) =>
                                                        const Registration(),
                                              ),
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Container(
                                          // 上と下は余白なし
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 15,
                                          ),
                                          color: const Color(0xffFCFAF2)
                                              .withOpacity(0.5),
                                          alignment: Alignment.center,
                                          child: Text('新規登録',
                                              style: GoogleFonts.sawarabiMincho(
                                                  color:
                                                      const Color(0xff43341B))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: Platform.isIOS
                                      ? MainAxisAlignment.spaceAround
                                      : MainAxisAlignment.center,
                                  children: [
                                    Platform.isIOS
                                        ? SignInButton.mini(
                                            buttonType: ButtonType.apple,
                                            onPressed: model.agreeToTerms ==
                                                    false
                                                ? null
                                                : () async {
                                                    final appleIdCredential =
                                                        await SignInWithApple
                                                            .getAppleIDCredential(
                                                      scopes: [
                                                        AppleIDAuthorizationScopes
                                                            .email,
                                                        AppleIDAuthorizationScopes
                                                            .fullName,
                                                      ],
                                                    );
                                                    final oAuthProvider =
                                                        OAuthProvider(
                                                            'apple.com');
                                                    final credential =
                                                        oAuthProvider
                                                            .credential(
                                                      idToken: appleIdCredential
                                                          .identityToken,
                                                      accessToken:
                                                          appleIdCredential
                                                              .authorizationCode,
                                                    );
                                                    try {
                                                      final result = await model
                                                          .auth
                                                          .signInWithCredential(
                                                              credential);

                                                      final user = result.user;
                                                      await model
                                                          .createUserDatabase(
                                                              user);
                                                      await Navigator
                                                          .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Home(
                                                                  auth: model
                                                                      .auth,
                                                                  uid: user.uid,
                                                                  adInterstitial:
                                                                      adInterstitial,
                                                                ),
                                                              ),
                                                              (_) => false);
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  })
                                        : const SizedBox.shrink(),
                                    SignInButton.mini(
                                      buttonType: ButtonType.google,
                                      onPressed: model.agreeToTerms == false
                                          ? null
                                          : () async {
                                              googleUser = (await GoogleSignIn()
                                                  .signIn());
                                              googleAuth = await googleUser
                                                  .authentication;
                                              credential =
                                                  GoogleAuthProvider.credential(
                                                accessToken:
                                                    googleAuth.accessToken,
                                                idToken: googleAuth.idToken,
                                              );
                                              try {
                                                final result = await model.auth
                                                    .signInWithCredential(
                                                        credential);
                                                final user = result.user;
                                                await model
                                                    .createUserDatabase(user);
                                                await Navigator
                                                    .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Home(
                                                            auth: model.auth,
                                                            uid: user.uid,
                                                            adInterstitial:
                                                                adInterstitial,
                                                          ),
                                                        ),
                                                        (_) => false);
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword(),
                                          ),
                                        );
                                      },
                                      child: Text('パスワードを忘れた方はこちら',
                                          style: GoogleFonts.sawarabiMincho(
                                              color: const Color(0xff33A6B8),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SizedBox(
                  height: 60,
                  child: AdWidget(
                    ad: banner,
                  )));
        }));
  }
}
