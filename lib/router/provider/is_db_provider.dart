import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/config/user_db/user_db_ref_provider.dart';
import 'package:app_55hz/router/provider/is_login_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_db_provider.g.dart';

@riverpod
FutureOr<bool> isDb(IsDbRef ref) async {
  if (!ref.watch(isLoginProvider)) {
    return false;
  }

  final currentUser = ref.watch(firebaseAuthInstanceProvider).currentUser!;
  final uid = currentUser.uid;
  final doc = await ref.watch(userDbRefProvider).doc(uid).get();

  return doc.data() != null;
}
