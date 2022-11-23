// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_error.dart';
import 'email_check.dart';

// アカウント登録ページ
class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // Firebase Authenticationを利用するためのインスタンス
  final _auth = FirebaseAuth.instance;
  UserCredential _result;
  User _user;

  String _newEmail = ""; // 入力されたメールアドレス
  String _newPassword = ""; // 入力されたパスワード
  String _infoText = ""; // 登録に関する情報を表示
  bool _pswd_OK = false; // パスワードが有効な文字数を満たしているかどうか

  // エラーメッセージを日本語化するためのクラス
  final auth_error = Authentication_error();

  @override
  Widget build(BuildContext context) {
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
            )),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 30.0),
                    child: Text('アカウント新規作成',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),

                // メールアドレスの入力フォーム
                Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "メールアドレス"),
                      onChanged: (String value) {
                        _newEmail = value;
                      },
                    )),

                // パスワードの入力フォーム
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
                  child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: "パスワード（8～20文字）"),
                      obscureText: true, // パスワードが見えないようRにする
                      maxLength: 20, // 入力可能な文字数
                      onChanged: (String value) {
                        if (value.length >= 8) {
                          _newPassword = value;
                          _pswd_OK = true;
                        } else {
                          _pswd_OK = false;
                        }
                      }),
                ),

                // 登録失敗時のエラーメッセージ
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                  child: Text(
                    _infoText,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

                // アカウント作成のボタン配置
                ButtonTheme(
                  minWidth: 350.0,
                  // height: 100.0,
                  // ignore: deprecated_member_use
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.grey),
                    onPressed: () async {
                      if (_pswd_OK) {
                        try {
                          // メール/パスワードでユーザー登録
                          _result = await _auth.createUserWithEmailAndPassword(
                            email: _newEmail,
                            password: _newPassword,
                          );

                          // 登録成功
                          _user = _result.user; // 登録したユーザー情報
                          _user.sendEmailVerification(); // Email確認のメールを送信
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Emailcheck(
                                    email: _newEmail,
                                    pswd: _newPassword,
                                    from: 1),
                              ));
                        } catch (e) {
                          // 登録に失敗した場合
                          setState(() {
                            print(e);
                            _infoText = auth_error.register_error_msg(e.code);
                          });
                        }
                      } else {
                        setState(() {
                          _infoText = 'パスワードは8文字以上です。';
                        });
                      }
                    },
                    child: const Text(
                      '登録',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('戻る'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
