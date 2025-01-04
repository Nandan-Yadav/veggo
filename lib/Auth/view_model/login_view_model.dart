import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veggo/Auth/model/auth_service.dart';
import 'package:veggo/Auth/view/otp_screen_view.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _loginScreenErrorCode;
  String? _verificationId;

  bool get isLoading => _isLoading;
  String? get loginerrorCode => _loginScreenErrorCode;

  Country _selectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    name: 'India',
    e164Sc: 0,
    geographic: true,
    level: 1,
    example: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
  );

  Country get selectedCountry => _selectedCountry;

  /// Updates the selected country.
  void updateSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
    debugPrint(
        '--- LoginViewModel: Selected country updated to: ${country.name} ---');
  }

  /// Sets the loading state.
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
    debugPrint('--- LoginViewModel: Loading state set to: $value ---');
  }

  /// Sets the error code.
  void setloginScreenErrorCode(String? code) {
    _loginScreenErrorCode = code;
    notifyListeners();
    debugPrint('--- LoginViewModel: Login Error code set to: $code ---');
  }

  /// Starts the phone number verification process.
  Future<void> startPhoneVerification(
      String phoneNumber, BuildContext context) async {
    setLoading(true);
    setloginScreenErrorCode(null);
    debugPrint(
        '--- LoginViewModel: Starting phone number verification for: $phoneNumber ---');

    await _authService.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onVerificationCompleted: (PhoneAuthCredential credential) async {
        debugPrint(
            '--- LoginViewModel: Verification completed with credential: $credential ---');
        await _authService.auth.signInWithCredential(credential);
      },
      onVerificationFailed: (e) {
        setloginScreenErrorCode(e.code);
        setLoading(false);
        debugPrint('--- LoginViewModel: Verification failed: ${e.message} ---');
        _showErrorSnackbar(context, _getFriendlyErrorMessage(e.code));
      },
      onCodeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        debugPrint(
            '--- LoginViewModel: Code sent with verificationId: $verificationId ---');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreenView(verificationId: verificationId),
          ),
        );
        Future.delayed(const Duration(seconds: 30), () {
          setLoading(false);
        });
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        debugPrint(
            '--- LoginViewModel: Code auto retrieval timeout for verificationId: $verificationId ---');
      },
    );
  }

  /// Shows an error snackbar with the provided message.
  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Maps Firebase error codes to user-friendly messages.
  String _getFriendlyErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-phone-number':
        return 'The phone number format is invalid. Please enter a valid phone number.';
      case 'invalid-verification-code':
        return 'The OTP you entered does not match the code sent. Please check and try again.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please try again.';
      case 'quota-exceeded':
        return 'The SMS quota for this project has been exceeded. Please try again later.';
      case 'missing-phone-number':
        return 'The phone number is required. Please enter your phone number.';
      case 'captcha-check-failed':
        return 'The reCAPTCHA verification failed. Please try again.';
      case 'missing-verification-code':
        return 'The verification code is required. Please enter the code sent to your phone.';
      case 'missing-verification-id':
        return 'The verification ID is required. Please try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Phone sign-in is disabled for this project. Please contact support.';
      case 'provider-already-linked':
        return 'This phone number is already linked to another account.';
      case 'credential-already-in-use':
        return 'This phone number is already associated with a different user account.';
      case 'unverified-email':
        return 'The email is not verified. Please verify your email first.';
      case 'session-expired':
        return 'The verification code has expired. Please request a new code.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection and try again.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
