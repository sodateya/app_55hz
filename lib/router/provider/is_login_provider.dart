import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_login_provider.g.dart';

@riverpod
class IsLogin extends _$IsLogin {
  @override
  bool build() {
    return ref.watch(firebaseAuthInstanceProvider).currentUser != null;
  }

  Future mailSignIn(String email, String pass) async {
    final result = await ref
        .read(firebaseAuthInstanceProvider)
        .signInWithEmailAndPassword(email: email, password: pass);

    state = result.user != null;
    return state;
  }
}

@riverpod
bool isCheckMailVerified(IsCheckMailVerifiedRef ref) =>
    ref.watch(firebaseAuthInstanceProvider).currentUser!.emailVerified;
