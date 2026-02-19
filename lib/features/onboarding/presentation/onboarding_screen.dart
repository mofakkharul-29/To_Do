import 'package:flutter/material.dart';
import 'package:to_do/core/constant/pages.dart';
import 'package:to_do/core/utils/custom_elevated_button.dart';
import 'package:to_do/core/utils/custom_page_indicator.dart';
import 'package:to_do/core/utils/custom_text_button.dart';
import 'package:to_do/features/onboarding/widgets/custom_page_builder.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      itemBuilder: (context, index) {
                        final currentPage = pages[index];
                        return CustomPageBuilder(
                          image: currentPage['image'],
                          title: currentPage['title'],
                        );
                      },
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: CustomTextButton(
                        onPressed: () {},
                        text: 'Skip',
                      ),
                    ),
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
                  child: const CustomPageIndicator(
                    height: 7,
                    width: 15,
                    radius: 5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 17),
            // elevated button
            CustomElevatedButton(
              onPressed: () {},
              text: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
