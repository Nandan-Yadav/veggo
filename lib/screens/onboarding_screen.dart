import "package:flutter/material.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";
import "package:veggo/services/onbarding_service.dart";

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  OnboardingIteams controller = OnboardingIteams();
  PageController pageController = PageController();

  late double _deviceheight;
  late double _devicewidth;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    // Add the onboarding items
    controller.addIteam(OnBoardingInfo(
        img: "assets/onboarding_gifs/onboarding1.gif",
        title: "Fresh & Hygienic Essentials",
        description:
            "Discover a variety of fresh and hygienic items, including vegetables, fruits, and milk, carefully sourced from the best marketplaces and local farmers. We prioritize quality and safety for our users, ensuring you receive the best for your family."));

    controller.addIteam(OnBoardingInfo(
        img: "assets/onboarding_gifs/onboarding2.gif",
        title: "Easy Delivery to Your Door Steps",
        description:
            "Experience hassle-free delivery service right to your doorstep, ensuring you receive fresh essentials without any effort."));

    controller.addIteam(OnBoardingInfo(
        img: "assets/onboarding_gifs/onboarding3.gif",
        title: "Secure Payment Options",
        description:
            "Order products within seconds using our flexible payment methods, including Cash on Delivery (COD) and UPI, ensuring a quick and secure checkout experience."));
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the device dimensions inside the build method where the context is available
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet: isLastPage
          ? getStarted()
          : Container(
              height: _deviceheight * 0.15,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.list.length - 1),
                    child: const Text(
                      "Skip",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.list.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn),
                    effect: const WormEffect(
                        dotColor: Color(0xFF388E3C),
                        dotHeight: 15,
                        dotWidth: 15,
                        activeDotColor: Color(0xFF194835)),
                  ),
                  TextButton(
                    onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
      body: Container(
        width: _devicewidth,
        height: _deviceheight,
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        child: PageView.builder(
          controller: pageController,
          itemCount: controller.list.length,
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.list.length - 1 == index),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  controller.list[index].img!,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.list[index].title!,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.list[index].description!,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF388E3C),
        ),
        width: MediaQuery.of(context).size.width * .9,
        height: 55,
        child: TextButton(
            onPressed: () {
              //   final pres = await SharedPreferences.getInstance();
              //   pres.setBool("onboarding", true);

              //   //After we press get started button this onboarding value become true
              //   // same key
              //   if(!mounted)return;
              //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            child: const Text(
              "Get started",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
