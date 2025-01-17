// import 'package:country_picker/country_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:veggo/Auth/view/otp_screen_view.dart';

// class CAuthProvider extends ChangeNotifier {
//   // Private variable to track signing in status
//   bool _isIsigningIn = false;
//   bool get isSigningIn => _isIsigningIn;

//   // Firebase Auth instance
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   // Default selected country
//   Country _selectedCountry = Country(
//     phoneCode: '91',
//     countryCode: 'IN',
//     name: 'India',
//     e164Sc: 0,
//     geographic: true,
//     level: 1,
//     example: 'India',
//     displayName: 'India',
//     displayNameNoCountryCode: 'IN',
//     e164Key: '',
//   );

//   Country get selectedCountry => _selectedCountry;

//   // Method to update the selected country
//   void updateSelectedCountry(Country country) {
//     debugPrint('--- Updating selected country to: ${country.name} ---');
//     _selectedCountry = country;
//     notifyListeners();
//     debugPrint('Selected country updated to: ${country.name}');
//   }

//   // Method to sign in with phone number
//   Future<void> signInWithPhoneNumber(
//       String phoneNumber, BuildContext context) async {
//     debugPrint('--- Starting phone number verification for: $phoneNumber ---');

//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           debugPrint(
//               '--- Verification completed with credential: $credential ---');
//           await _auth.signInWithCredential(credential);
//           //Navigator.pushNamed(context, '/home');
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           debugPrint('--Verification failed: ${e.message}');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 backgroundColor: Colors.red,
//                 content:
//                     Text('Verification failed. Please try again.${e.message}')),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           debugPrint(
//               '--- Code sent to $phoneNumber with verificationId: $verificationId ---');
//           Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => OtpScreenView(verificationId: verificationId),
//     ),
//   );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           debugPrint(
//               '--- Code auto retrieval timeout for verificationId: $verificationId ---');
//         },
//       );
//     } on FirebaseAuthException catch (e) {
//       debugPrint('--- Error during phone number verification: $e ---');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred!-> ${e.message}')),
//       );
//     }
//   }

//   // Method to verify OTP
//   Future<void> verifyOTP(
//       String verificationId, String smsOtp, BuildContext context) async {
//     debugPrint(
//         '--- Verifying SMS OTP: $smsOtp for verificationId: $verificationId ---');

//     try {
//       // Create a PhoneAuthCredential with the verification ID and the OTP
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsOtp,
//       );

//       // Sign in with the credential
//       await _auth.signInWithCredential(credential);
//       debugPrint('--- OTP verified successfully ---');
//       Navigator.pushNamed(context, '/home');
//     } on FirebaseAuthException catch (e) {
//       debugPrint('--- Error during OTP verification: ${e.message} ---');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             backgroundColor: Colors.red,
//             content: Text(
//                 'OTP verification failed. Please try again. ${e.message}')),
//       );
//     }
//   }
// }
