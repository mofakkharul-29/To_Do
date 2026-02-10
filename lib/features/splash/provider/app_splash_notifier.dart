import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSplashNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void updateSplashStatus(bool value) {
    state = value;
  }

  void resetSplashStatus(bool value) {
    state = value;
  }

  bool get splashStatus => state;
}

final appSplashNotifierProvider =
    NotifierProvider<AppSplashNotifier, bool>(
      AppSplashNotifier.new,
    );
