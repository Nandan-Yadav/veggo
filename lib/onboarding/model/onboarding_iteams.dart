// --- OnBoardingInfo Class ---
class OnBoardingInfo {
  final String img;
  final String title;
  final String description;

  OnBoardingInfo({
    required this.img,
    required this.title,
    required this.description,
  });
}

// --- OnboardingItems Class ---
class OnboardingItems {
  final List<OnBoardingInfo> list = [];

  void addItem(OnBoardingInfo item) {
    list.add(item);
  }
}
