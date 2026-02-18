import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/data/auth_state_change_provider.dart';
import 'package:to_do/features/auth/domain/app_user.dart';
import 'package:to_do/features/onboarding/domain/onboarding_notifier.dart';
import 'package:to_do/features/splash/provider/app_splash_notifier.dart';

class RoutingListenable extends ChangeNotifier {
  final Ref ref;

  bool _isSplashDone = false;
  bool _isFirstLaunch = true;
  AppUser? _currentUser;
  bool _isOnboardingLoading = true;
  bool _isAuthLoading = true;

  RoutingListenable(this.ref) {
    _isSplashDone = ref.read(appSplashNotifierProvider);

    final onboardingState = ref.read(
      onboardingStatusProvider,
    );
    _isOnboardingLoading = onboardingState.isLoading;
    _isFirstLaunch = onboardingState.value ?? true;

    final authState = ref.read(appUserProvider);
    _isAuthLoading = authState.isLoading;
    _currentUser = authState.value;

    ref.listen(onboardingStatusProvider, (previous, next) {
      _isOnboardingLoading = next.isLoading;
      _isFirstLaunch = next.value ?? true;
      notifyListeners();
    });

    ref.listen(appUserProvider, (previous, next) {
      _isAuthLoading = next.isLoading;
      _currentUser = next.value;
      notifyListeners();
    });

    ref.listen(appSplashNotifierProvider, (previous, next) {
      _isSplashDone = next;
      notifyListeners();
    });
  }

  bool get isSplashDone => _isSplashDone;
  bool get isFirstLaunch => _isFirstLaunch;
  AppUser? get currentUser => _currentUser;
  bool get isAppLoading =>
      _isOnboardingLoading || _isAuthLoading;
}

final routingListenableProvider =
    Provider<RoutingListenable>((ref) {
      return RoutingListenable(ref);
    });
