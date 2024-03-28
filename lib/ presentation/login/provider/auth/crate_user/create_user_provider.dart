import 'package:app_55hz/%20presentation/block/provider/block_ref_provider.dart';
import 'package:app_55hz/%20presentation/favorite/provider/favorite_ref_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/config/user_db/user_db_ref_provider.dart';
import 'package:app_55hz/model/user/user_9ch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_user_provider.g.dart';

@riverpod
class CreateUser extends _$CreateUser {
  @override
  build() {
    return '';
  }

  Future createUserDb() async {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    final token = await FirebaseMessaging.instance.getToken();
    final udid = await FlutterUdid.udid;
    final userData = User9ch(
        pushToken: token!, udid: udid, uid: uid, uid20: uid.substring(20));
    await ref.read(userDbRefProvider).doc(uid).set(userData);
  }

  Future createBlockDb() async {
    await ref.read(blockRefProvider).set({'blockUsers': []});
  }

  Future createFavoriteDb() async {
    await ref.read(favoriteRefProvider).set({'favoriteThreads': []});
  }
}
