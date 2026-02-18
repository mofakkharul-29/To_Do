import 'package:flutter/material.dart';
import 'package:to_do/core/constant/pages.dart';
import 'package:to_do/features/onboarding/widgets/custom_page_builder.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        148,
        121,
        224,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5,
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        final currentPage = pages[index];
                        return CustomPageBuilder(
                          image: currentPage['image'],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            // page indicatior
            // List.generate(length, generator)

            // elevated button
            ElevatedButton(
              onPressed: () {},
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
