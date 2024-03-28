enum FirebaseAuthErrorCodes {
  userNotFound(message: '指定されたユーザーは登録されていません。'),
  userDisabled(message: '指定されたユーザーは無効化されています。'),
  requiresRecentLogin(message: 'アカウント削除などのセキュアな操作を行うにはログインによる再認証が必要です。'),
  emailAlreadyInUse(message: '既に利用されているメールアドレスです。'),
  invalidEmail(message: '不正なメールアドレスです。'),
  wrongPassword(message: 'メールアドレス、またはパスワードが間違っています。'),
  tooManyRequests(message: 'ログインの試行回数が上限に達しました。少し時間を置いてから再度お試しください。'),
  expiredActionCode(message: 'メールアドレスリンクの期限が切れています。再度認証メールを送信してください。'),
  networkError(message: 'ネットワークに接続できませんでした。通信環境の良いところで再度お試ししください。'),
  invalidPhoneNumber(message: '電話番号が正しくありません'),
  invalidVerificationCode(message: '認証コードが正しくありません'),
  missingClientIdentifier(message: 'リクエストに有効なアプリ識別子がありません'),
  timeout(message: 'タイムアウトしました'),
  unknown(message: '予期しないエラーが発生しました。');

  const FirebaseAuthErrorCodes({required this.message});

  final String message;

  static FirebaseAuthErrorCodes fromCode(String code) {
    return switch (code) {
      'user-not-found' => FirebaseAuthErrorCodes.userNotFound,
      'user-disabled' => FirebaseAuthErrorCodes.userDisabled,
      'requires-recent-login' => FirebaseAuthErrorCodes.requiresRecentLogin,
      'email-already-in-use' => FirebaseAuthErrorCodes.emailAlreadyInUse,
      'invalid-email' => FirebaseAuthErrorCodes.invalidEmail,
      'wrong-password' => FirebaseAuthErrorCodes.wrongPassword,
      'too-many-requests' => FirebaseAuthErrorCodes.tooManyRequests,
      'expired-action-code' => FirebaseAuthErrorCodes.expiredActionCode,
      'network-request-failed' => FirebaseAuthErrorCodes.networkError,
      'invalid-phone-number' => FirebaseAuthErrorCodes.invalidPhoneNumber,
      'invalid-verification-code' =>
        FirebaseAuthErrorCodes.invalidVerificationCode,
      'missing-client-identifier' =>
        FirebaseAuthErrorCodes.missingClientIdentifier,
      _ => FirebaseAuthErrorCodes.unknown,
    };
  }
}
