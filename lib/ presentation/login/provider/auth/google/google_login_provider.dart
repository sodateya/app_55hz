import 'package:app_55hz/%20presentation/login/enum/firebase_error_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase_auth/firebase_auth_provider.dart';

part 'google_login_provider.g.dart';

@riverpod
class GoogleLogin extends _$GoogleLogin {
  @override
  FutureOr<void> build() {}
  Future googleLogin() async {
    if (state.isLoading) {
      return;
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Google認証
      GoogleSignInAccount? signinAccount = await GoogleSignIn().signIn();

      GoogleSignInAuthentication auth = await signinAccount!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
        accessToken: auth.accessToken,
      );

      try {
        await ref
            .read(firebaseAuthInstanceProvider)
            .signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        throw Exception(FirebaseAuthErrorCodes.fromCode(e.code).message);
      } on Exception catch (e) {
        throw Exception('予期せぬエラーが発生しました:${e.toString()}');
      }
    });
    return state;
  }
}
