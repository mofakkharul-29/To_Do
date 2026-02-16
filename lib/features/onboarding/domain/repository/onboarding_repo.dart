import 'package:to_do/features/onboarding/data/onboarding_local_data_source.dart';

class OnboardingRepo {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepo(this.localDataSource);

  Future<bool> requiresOnboarding() async {
    return await localDataSource.isFirstLaunch();
  }

  Future<void> completeOnboarding() async {
    await localDataSource.setFirstLaunch(false);
  }
}
