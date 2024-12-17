import 'package:veggo/data/onboarding_data.dart';
import 'package:veggo/onboarding/model/onboarding_iteams.dart';

class OnboardingModel {
  List<OnBoardingInfo> getOnboardingItems() {
    final items = OnboardingItems();

    items.addItem(OnBoardingInfo(
      img: OnboardingData.src1,
      title: OnboardingData.onBoardingTitle1,
      description: OnboardingData.onBoardingDescription1,
    ));

    items.addItem(OnBoardingInfo(
      img: OnboardingData.src2,
      title: OnboardingData.onBoardingTitle2,
      description: OnboardingData.onBoardingDescription2,
    ));

    items.addItem(OnBoardingInfo(
      img: OnboardingData.src3,
      title: OnboardingData.onBoardingTitle3,
      description: OnboardingData.onBoardingDescription3,
    ));

    return items.list;
  }
}