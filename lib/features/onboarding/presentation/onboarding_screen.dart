import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/constant/pages.dart';
import 'package:to_do/core/utils/custom_elevated_button.dart';
import 'package:to_do/core/utils/custom_page_indicator.dart';
import 'package:to_do/core/utils/custom_text_button.dart';
import 'package:to_do/features/onboarding/domain/onboarding_notifier.dart';
import 'package:to_do/features/onboarding/domain/repository/page_indicator.dart';
import 'package:to_do/features/onboarding/widgets/custom_page_builder.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = ref
        .read(pageIndicatorProvider.notifier)
        .pageController;
    final pageNotifier = ref.read(
      pageIndicatorProvider.notifier,
    );

    final onboardingStatus = ref.read(
      onboardingStatusProvider.notifier,
    );
    final currentPage = ref.watch(pageIndicatorProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        53,
        45,
        77,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20,
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: pages.length,
                      controller: controller,
                      itemBuilder: (context, index) {
                        final currentPage = pages[index];
                        return CustomPageBuilder(
                          image: currentPage['image'],
                          title: currentPage['title'],
                        );
                      },
                      onPageChanged: (value) {
                        pageNotifier.onPageChange(value);
                      },
                    ),
                    currentPage < pages.length - 1
                        ? Positioned(
                            top: 0,
                            right: 10,
                            child: CustomTextButton(
                              onPressed: () {
                                pageNotifier.onSkipTap(
                                  pages.length - 1,
                                );
                              },
                              text: 'Skip',
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: CustomPageIndicator(
                    height: 7,
                    width: currentPage == index ? 22 : 15,
                    radius: 5,
                    color: currentPage == index
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 17),
            // elevated button
            CustomElevatedButton(
              color: currentPage == pages.length - 1
                  ? Colors.blue
                  : Color.fromARGB(158, 117, 116, 116),
              onPressed: () {
                if (currentPage < pages.length - 1) {
                  pageNotifier.goToNextPage(
                    currentPage + 1,
                  );
                } else {
                  onboardingStatus.completeOnboarding();
                }
              },
              text:
                  (currentPage >= 0 &&
                      currentPage < pages.length - 1)
                  ? 'Next'
                  : 'Get Started',
            ),
          ],
        ),
      ),
    );
  }
}
