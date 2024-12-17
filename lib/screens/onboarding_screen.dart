import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veggo/onboarding/view/bottomsheet_buttons.dart';
import 'package:veggo/onboarding/view/onboarding_pageview.dart';
import 'package:veggo/onboarding/model/onboarding_model.dart';
import 'package:veggo/onboarding/model/onboarding_iteams.dart';
import 'package:veggo/onboarding/controller/bottomsheet_navigation_provider.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const OnboardingScreenContent();
  }
}

class OnboardingScreenContent extends StatefulWidget {
  const OnboardingScreenContent({super.key});

  @override
  State<OnboardingScreenContent> createState() =>
      _OnboardingScreenContentState();
}

class _OnboardingScreenContentState extends State<OnboardingScreenContent> {
  List<OnBoardingInfo>? items;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    items = OnboardingModel().getOnboardingItems();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Consumer<BottomsheetNavigationProvider>(
        builder: (context, provider, _) {
          log(1);
          return BottomSheetNavigationsButtons(
            pageController: pageController,
            count: items!.length,
            isLastPage: provider.currentPage == items!.length - 1,
          );
        },
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: items!.length,
        onPageChanged: (index) {
          Provider.of<BottomsheetNavigationProvider>(context, listen: false)
              .updatePage(index);
        },
        itemBuilder: (context, index) {
          return OnboardingPageView(item: items![index]);
        },
      ),
    );
  }
}
