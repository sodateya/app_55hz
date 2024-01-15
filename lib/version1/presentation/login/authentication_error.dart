// Firebase Authentication利用時の日本語エラーメッセージ
// ignore_for_file: non_constant_identifier_names

// ignore: camel_case_types
class Authentication_error {
  // ログイン時の日本語エラーメッセージ
  login_error_msg(String errorCode) {
    String errorMsg;

    if (errorCode == 'invalid-email') {
      errorMsg = '有効なメールアドレスを入力してください。';
    } else if (errorCode == 'user-not-found') {
      // 入力されたメールアドレスが登録されていない場合
      errorMsg = 'メールアドレスかパスワードが間違っています。';
    } else if (errorCode == 'wrong-password') {
      // 入力されたパスワードが間違っている場合
      errorMsg = 'メールアドレスかパスワードが間違っています。';
    } else if (errorCode == 'error') {
      // メールアドレスかパスワードがEmpty or Nullの場合
      errorMsg = 'メールアドレスとパスワードを入力してください。';
    } else {
      errorMsg = errorCode;
    }

    return errorMsg;
  }

  // アカウント登録時の日本語エラーメッセージ
  register_error_msg(String errorCode) {
    String errorMsg;

    if (errorCode == 'invalid-email') {
      errorMsg = '有効なメールアドレスを入力してください。';
    } else if (errorCode == 'email-already-in-use') {
      // メールアドレスかパスワードがEmpty or Nullの場合
      errorMsg = '既に登録済みのメールアドレスです。';
    } else if (errorCode == 'error') {
      // メールアドレスかパスワードがEmpty or Nullの場合
      errorMsg = 'メールアドレスとパスワードを入力してください。';
    } else {
      errorMsg = errorCode;
    }

    return errorMsg;
  }
}
