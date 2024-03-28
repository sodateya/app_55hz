import 'package:app_55hz/%20presentation/login/enum/firebase_error_codes.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'apple_login_provider.g.dart';

@riverpod
class AppleLogin extends _$AppleLogin {
  @override
  FutureOr<void> build() {}
  Future appleLogin() async {
    if (state.isLoading) {
      return;
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final appleProvider = AppleAuthProvider();
      try {
        await ref
            .read(firebaseAuthInstanceProvider)
            .signInWithProvider(appleProvider);
      } on FirebaseAuthException catch (e) {
        throw Exception(FirebaseAuthErrorCodes.fromCode(e.code).message);
      } on Exception catch (e) {
        throw Exception('予期せぬエラーが発生しました:${e.toString()}');
      }
    });
    return state;
  }
}
