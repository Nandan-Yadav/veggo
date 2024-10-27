class OnBoardingInfo {
  String? img;
  String? title;
  String? description;

  OnBoardingInfo(
      {required this.img, required this.title, required this.description});
}

class OnboardingIteams {
  List<OnBoardingInfo> list = [];

  void addIteam(OnBoardingInfo item) {
    list.add(item);
  }

}



