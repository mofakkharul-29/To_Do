import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      state = 'Email is required';
      return;
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      state = 'Enter a valid email';
      return;
    }
    state = null;
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      state = 'password can\'t be empty';
      return;
    }
    if (value.length < 6) {
      state = 'Password must be at least 6 characters';
      return;
    }
    state = null;
  }
}

final emailErrorProvider =
    NotifierProvider<TextFieldNotifier, String?>(
      TextFieldNotifier.new,
    );

final passwordErrorProvider =
    NotifierProvider<TextFieldNotifier, String?>(
      TextFieldNotifier.new,
    );
