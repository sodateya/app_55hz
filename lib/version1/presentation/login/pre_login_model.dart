import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'authentication_error.dart';

class LoginModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  String infoText = ""; // ログインに関する情報を表示
  final auth_error = Authentication_error(); // エラーメッセージを日本語化するためのクラス
  bool isreadAgree = false;
  bool ischeckedAgree = false;
  UserCredential? result;
  User? user;
  AuthorizationCredentialAppleID? appleIdCredential;

  Future readAgree() async {
    isreadAgree = true;
    print(isreadAgree);
    notifyListeners();
  }

  Future checkedAgree() async {
    ischeckedAgree = true;
    notifyListeners();
  }

  void loginErrorMessage(dynamic e) {
    print(e);
    infoText = auth_error.login_error_msg(e.code);
    notifyListeners();
  }

  Future createUserDatabase(User user) async {
    final token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('blockList')
        .doc(user.uid.substring(20))
        .set({'blockUsers': []});
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('favoriteList')
        .doc(user.uid.substring(25))
        .set({'favoriteThreads': []});
    await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
      'uid': user.uid,
      'uid20': user.uid.substring(20),
      'udid': await FlutterUdid.udid,
      'pushToken': token
    });
  }

  Future lunchTermsOfService() async {
    await launch('https://hz-360fa.web.app/');
    notifyListeners();
  }
}
