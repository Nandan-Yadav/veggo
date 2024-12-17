import 'package:flutter/material.dart';

class DeviceUtilities {
  static deviceHight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static deviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static deviceOrientation(BuildContext context) {
    return MediaQuery.orientationOf(context);
  }
}
