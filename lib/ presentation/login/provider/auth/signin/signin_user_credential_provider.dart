import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signin_user_credential_provider.g.dart';

@riverpod
class SigninUserCredential extends _$SigninUserCredential {
  @override
  UserCredential? build() {
    UserCredential? userCredential;
    return userCredential;
  }

  Future mailLogIn(String mail, String pwd) async {
    final result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: pwd);
    state = result;
    return result;
  }
}
