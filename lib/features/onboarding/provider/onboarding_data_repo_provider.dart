import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/onboarding/data/onboarding_local_data_source.dart';
import 'package:to_do/features/onboarding/domain/repository/onboarding_repo.dart';

final onboardingLocalDataSourceProvider = Provider(
  (ref) => OnboardingLocalDataSource(),
);

final onboardingRepoProvider = Provider(
  (ref) => OnboardingRepo(
    ref.read(onboardingLocalDataSourceProvider),
  ),
);
