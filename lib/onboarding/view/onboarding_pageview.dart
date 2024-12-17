import 'package:flutter/material.dart';
import 'package:veggo/onboarding/model/onboarding_iteams.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';

class OnboardingPageView extends StatelessWidget {
  final OnBoardingInfo item;
  const OnboardingPageView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.paddingMd),
      child: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return (orientation == Orientation.portrait)
              ? portraitPageView(context)
              : landScapePageView(context);
        }),
      ),
    );
  }

  Widget portraitPageView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: CSizes.appBarHeight,
        ),
        Image.asset(item.img,
            fit: BoxFit.cover,
            height: DeviceUtilities.deviceHight(context) * .5),
        Text(
          item.title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: CSizes.paddingSm,
        ),
        Text(
          item.description,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget landScapePageView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(item.img,
            fit: BoxFit.cover,
            height: DeviceUtilities.deviceHight(context) * .5),
        Text(
          item.title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: CSizes.paddingSm,
        ),
        Text(
          item.description,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
