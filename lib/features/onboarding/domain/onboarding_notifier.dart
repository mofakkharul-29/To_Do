import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/onboarding/provider/onboarding_data_repo_provider.dart';

class OnboardingNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final repo = ref.read(onboardingRepoProvider);
    return await repo.requiresOnboarding();
  }

  Future<void> completeOnboarding() async {
    final repo = ref.read(onboardingRepoProvider);
    await repo.completeOnboarding();
    state = const AsyncData(false);
  }
}

final onboardingStatusProvider =
    AsyncNotifierProvider<OnboardingNotifier, bool>(
      OnboardingNotifier.new,
    );
