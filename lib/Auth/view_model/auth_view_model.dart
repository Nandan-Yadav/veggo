// import 'package:country_picker/country_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:veggo/Auth/model/auth_service.dart';
// import 'package:veggo/Auth/view/otp_screen_view.dart';

// class AuthViewModel extends ChangeNotifier {
//   /// Instance of the [AuthService] class.
//   final AuthService _authService = AuthService();

//   /// Loading state.
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   /// Error code.
//   String? _loginScreenErrorCode;
//   String? get loginerrorCode => _loginScreenErrorCode;

//   /// OTP Error code.
//   String? _otpScreenErrorCode;
//   String? get otpErrorCode => _otpScreenErrorCode;

//   /// Verification ID.
//   String? _verificationId;
  
//   /// Default selected country.
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

//   /// Getter for the selected country.
//   Country get selectedCountry => _selectedCountry;

//   /// Updates the selected country.
//   void updateSelectedCountry(Country country) {
//     _selectedCountry = country;
//     notifyListeners();
//     debugPrint('--- AuthViewModel: Selected country updated to: ${country.name} ---');
//   }

//   /// Sets the loading state.
//   void setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//     debugPrint('--- AuthViewModel: Loading state set to: $value ---');
//   }

//   /// Sets the error code.
//   void setotpScreenErrorCode(String? code) {
//     _otpScreenErrorCode = code;
//     notifyListeners();
//     debugPrint('--- AuthViewModel: OTP Error code set to: $code ---');
//   }

//   void setloginScreenErrorCode(String? code) {
//     _loginScreenErrorCode = code;
//     notifyListeners();
//     debugPrint('--- AuthViewModel: Login Error code set to: $code ---');
//   }

//   /// Starts the phone number verification process.
//   Future<void> startPhoneVerification(String phoneNumber, BuildContext context) async {
//     setLoading(true);
//     setloginScreenErrorCode(null);
//     debugPrint('--- AuthViewModel: Starting phone number verification for: $phoneNumber ---');

//     await _authService.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       onVerificationCompleted: (PhoneAuthCredential credential) async {
//         debugPrint('--- AuthViewModel: Verification completed with credential: $credential ---');
//         await  _authService.auth.signInWithCredential(credential);
//       },
//       onVerificationFailed: (e) {
//         setloginScreenErrorCode(e.code);
//         setLoading(false);
//         debugPrint('--- AuthViewModel: Verification failed: ${e.message} ---');
//         _showErrorSnackbar(context, _getFriendlyErrorMessage(e.code));
//       },
//       onCodeSent: (String verificationId, int? resendToken) {
//         _verificationId = verificationId;
//         debugPrint('--- AuthViewModel: Code sent with verificationId: $verificationId ---');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpScreenView(verificationId: verificationId),
//           ),
//         );
//       },
//       onCodeAutoRetrievalTimeout: (String verificationId) {
//         _verificationId = verificationId;
//         debugPrint('--- AuthViewModel: Code auto retrieval timeout for verificationId: $verificationId ---');
//       },
//     );
//     setLoading(false);
//   }

//   /// Verifies the OTP.
//   Future<void> signInWithOtp(String otp, BuildContext context) async {
//     if (_verificationId == null) {
//       setotpScreenErrorCode('invalid-verification-id');   
//       debugPrint('--- AuthViewModel: Verification ID is null ---');
//       _showErrorSnackbar(context, 'Verification ID is null');
//       return;
//     }

//     setLoading(true);
//     setotpScreenErrorCode(null);
//     debugPrint('--- AuthViewModel: Verifying OTP: $otp ---');

//     await _authService.verifyOtp(
//       verificationId: _verificationId!,
//       otp: otp,
//       onSuccess: () {
//         debugPrint('--- AuthViewModel: OTP verification successful ---');
//         debugPrint('--- AuthViewModel: Navigating to home screen ---');
//         Navigator.pushNamed(context, '/home');
//         setLoading(false);
//       },
//       onError: (e) {
//         setotpScreenErrorCode(e.code);
//         setLoading(false);
//         debugPrint('--- AuthViewModel: OTP verification failed: ${e.message} ---');
//         _showErrorSnackbar(context, _getFriendlyErrorMessage(e.code));
//       },

//     );
//   }

//   /// Shows an error snackbar with the provided message.
//   void _showErrorSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   /// Maps Firebase error codes to user-friendly messages.
//   String _getFriendlyErrorMessage(String errorCode) {
//     switch (errorCode) {
//       case 'invalid-phone-number':
//         return 'The phone number format is invalid. Please enter a valid phone number.';
//       case 'invalid-verification-code':
//         return 'The OTP you entered does not match the code sent. Please check and try again.';
//       case 'invalid-verification-id':
//         return 'The verification ID is invalid. Please try again.';
//       case 'quota-exceeded':
//         return 'The SMS quota for this project has been exceeded. Please try again later.';
//       case 'missing-phone-number':
//         return 'The phone number is required. Please enter your phone number.';
//       case 'captcha-check-failed':
//         return 'The reCAPTCHA verification failed. Please try again.';
//       case 'missing-verification-code':
//         return 'The verification code is required. Please enter the code sent to your phone.';
//       case 'missing-verification-id':
//         return 'The verification ID is required. Please try again.';
//       case 'too-many-requests':
//         return 'Too many requests. Please try again later.';
//       case 'operation-not-allowed':
//         return 'Phone sign-in is disabled for this project. Please contact support.';
//       case 'provider-already-linked':
//         return 'This phone number is already linked to another account.';
//       case 'credential-already-in-use':
//         return 'This phone number is already associated with a different user account.';
//       case 'unverified-email':
//         return 'The email is not verified. Please verify your email first.';
//       case 'session-expired':
//         return 'The verification code has expired. Please request a new code.';
//       case 'network-request-failed':
//         return 'A network error occurred. Please check your connection and try again.';
//       default:
//         return 'An unknown error occurred. Please try again.';
//     }
//   }
// }