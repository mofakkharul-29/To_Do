String getFriendlyError(dynamic error) {
  final msg = error.toString().toLowerCase();

  if (msg.contains('invalid-credential') ||
      msg.contains('wrong-password')) {
    return 'Invalid email or password';
  }
  if (msg.contains('user-not-found')) {
    return 'User does not exist';
  }
  if (msg.contains('network-request-failed')) {
    return 'Check your internet connection';
  }
  if (msg.contains(
    'account-exists-with-different-credential',
  )) {
    return 'Account exists with different sign-in method';
  }
  return 'Something went wrong. Please try again.';
}
