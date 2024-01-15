import 'package:app_55hz/version1/main/admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountDeleteModel extends ChangeNotifier {
  String udid = 'UDID';

  void openMailApp(String uid, String mail) async {
    final String title = Uri.encodeComponent('9ちゃんねるお問い合わせメール');
    final String body = Uri.encodeComponent(
        '\n〜ユーザー情報〜\n\nユーザーID \n${uid.substring(20)}\nメールアドレス\n$mail\n\n ');
    const mailAddress = '9channeru@gmail.com'; //メールアドレス
    notifyListeners();

    return launchMail(
      'mailto:$mailAddress?subject=$title&body=$body',
    );
  }

  Future<void> launchMail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
    notifyListeners();
  }

  Future deleteAccount(
      BuildContext context, AdInterstitial adInterstitial) async {
    await FirebaseAuth.instance.currentUser!.delete();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Column(
            children: [
              Text('アカウントを削除しました',
                  style: GoogleFonts.sawarabiMincho(
                      color: const Color(0xffFCFAF2), fontSize: 15)),
            ],
          ),
        );
      },
    );
  }
}
