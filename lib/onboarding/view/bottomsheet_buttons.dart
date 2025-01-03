import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/local_storage/onboarding_shared_preferences.dart';

class BottomSheetNavigationsButtons extends StatelessWidget {
  final PageController pageController;
  final int count;
  final bool isLastPage;

  const BottomSheetNavigationsButtons({
    super.key,
    required this.pageController,
    required this.count,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(CSizes.paddingMd),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: isLastPage
            ? getStartedButton(context)
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dotIndicator(),
                  const SizedBox(height: CSizes.paddingSm),
                  navigationButtons(context),
                ],
              ));
  }

  Widget dotIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      onDotClicked: (index) => pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      ),
      effect: const WormEffect(
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: CColors.primary,
      ),
    );
  }

  Widget navigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        skipButton(context),
        const SizedBox(width: CSizes.paddingLg),
        nextButton(context),
      ],
    );
  }

  Widget nextButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: CColors.primary,
          fixedSize: const Size(double.infinity, CSizes.buttonHeight),
        ),
        onPressed: () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
        child: Text(
          'Next',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget skipButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: CColors.accent,
          fixedSize: const Size(double.infinity, CSizes.buttonHeight),
        ),
        onPressed: () {
          pageController.jumpToPage(count - 1);
        },
        child: Text(
          'Skip',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: CColors.primary),
        ),
      ),
    );
  }

  Widget getStartedButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: CColors.primary,
        fixedSize: const Size(double.infinity, CSizes.buttonHeight),
      ),
      onPressed: () async {
        LocalStorageService.setOnboardingCompleted(true);
        debugPrint(
            'Onboarding completed. Stored value: ${LocalStorageService.isOnboardingCompleted()} }');

        Navigator.of(context)
            .pushReplacementNamed('/sign_in'); // Navigate to Sign Up Screen
      },
      child: Text(
        'Get Started',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
