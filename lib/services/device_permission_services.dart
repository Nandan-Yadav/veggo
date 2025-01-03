// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:veggo/services/alertdialog_services.dart';
// import 'package:flutter/material.dart';
// import 'package:veggo/services/snackbar_service.dart';
// import 'package:veggo/utilities/custom_widgets.dart';

// class PermissionHandler {
//   Future<void> requestLocationPermission(BuildContext context) async {
//     PermissionStatus status = await Permission.location.status;

//     try {
//       if (status.isGranted) {
//         onGranted(context);
//       } else if (status.isDenied) {
//         PermissionStatus newStatus = await Permission.location.request();

//         if (newStatus.isGranted) {
//           onGranted(context);
//         } else {
//           onDeniedPermanentlyDenied(context);
//         }
//       } else {
//         onDeniedPermanentlyDenied(context);
//       }
//     } catch (e) {
//       debugPrint("Error requesting location permission: $e");
//       await showErrorDialog(
//           context, "An error occurred while requesting permission.");
//     }
//   }

//   Future<void> onGranted(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool('onboarded', true);
//     Navigator.pushReplacementNamed(context, '/home');
//   }

//   Future<void> onDeniedPermanentlyDenied(BuildContext context) async {
//     await showAlertDialog(
//       context: context,
//       title: "Turn On Location Permission",
//       content:
//           "Please go to Settings -> Location to turn on Location Permission",
//       actions: [
//         Expanded(
//           child: reUsableTextButton(
//             text: 'Cancel',
//             backgroundColor: Color(AppColors.lightGreen.color.value),
//             foregroundColor: Color(AppColors.green.color.value),
//             onPress: () async {
//               Navigator.pop(context);
//               await SnackbarService(context).showSnackBarWithIconMessage(
//                   icon: Icons.location_on,
//                   title:
//                       "Granting location access helps ensure accurate service and address availability.");
//             },
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: reUsableTextButton(
//             text: 'Settings',
//             onPress: () async {
//               Navigator.pop(context);
//               await openAppSettings();
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> showErrorDialog(BuildContext context, String message) async {
//     await showAlertDialog(
//       context: context,
//       title: "Error",
//       content: message,
//       actions: [
//         TextButton(
//           child: const Text("OK"),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }
// }
