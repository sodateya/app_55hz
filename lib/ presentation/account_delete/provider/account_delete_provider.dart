import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'account_delete_provider.g.dart';

@riverpod
class AccountDelete extends _$AccountDelete {
  @override
  build() {
    return '';
  }

  void openMailApp(String uid, String mail) async {
    final String title = Uri.encodeComponent('9ちゃんねるお問い合わせメール');
    final String body = Uri.encodeComponent(
        '\n〜ユーザー情報〜\n\nユーザーID \n${uid.substring(20)}\nメールアドレス\n$mail\n\n ');
    const mailAddress = '9channeru@gmail.com'; //メールアドレス

    return launchMail(
      'mailto:$mailAddress?subject=$title&body=$body',
    );
  }

  Future<void> launchMail(String url) async {
    launchUrl(Uri.parse(url));
  }
}
