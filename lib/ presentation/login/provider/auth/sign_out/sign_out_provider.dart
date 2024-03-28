import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  build() {
    return '';
  }

  Future signOut() async {
    await ref.read(firebaseAuthInstanceProvider).signOut();
    GoogleSignIn().signOut();
  }
}
