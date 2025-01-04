import 'package:flutter/material.dart';
import 'package:veggo/Auth/model/auth_service.dart';

class OtpViewModel extends ChangeNotifier {
  
  /// Instance of the [AuthService] class.
  final AuthService _authService = AuthService();
  /// Loading state.
  bool _isLoading = false;
  /// Error code.
  String? _otpScreenErrorCode;

  bool get isLoading => _isLoading;
  String? get otpErrorCode => _otpScreenErrorCode;

  /// Sets the loading state.
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
    debugPrint('--- OtpViewModel: Loading state set to: $value ---');
  }

  /// Sets the error code.
  void setotpScreenErrorCode(String? code) {
    _otpScreenErrorCode = code;
    notifyListeners();
    debugPrint('--- OtpViewModel: OTP Error code set to: $code ---');
  }

  /// Verifies the OTP.
  Future<void> signInWithOtp(String? verificationId, String otp, BuildContext context) async {
    if (verificationId == null) {
      setotpScreenErrorCode('invalid-verification-id');
      debugPrint('--- OtpViewModel: Verification ID is null ---');
      _showErrorSnackbar(context, 'Verification ID is null');
      return;
    }

    setLoading(true);
    setotpScreenErrorCode(null);
    debugPrint('--- OtpViewModel: Verifying OTP: $otp ---');

    await _authService.verifyOtp(
      verificationId: verificationId,
      otp: otp,
      onSuccess: () {
        debugPrint('--- OtpViewModel: OTP verification successful ---');
        debugPrint('--- OtpViewModel: Navigating to home screen ---');
        Navigator.pushNamed(context, '/home');
        setLoading(false);
      },
      onError: (e) {
        setotpScreenErrorCode(e.code);
        setLoading(false);
        debugPrint('--- OtpViewModel: OTP verification failed: ${e.message} ---');
        _showErrorSnackbar(context, _getFriendlyErrorMessage(e.code));
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