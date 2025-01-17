import 'dart:async';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veggo/Auth/model/auth_service.dart';
import 'package:veggo/services/auth_error_service.dart';
import 'package:veggo/services/snackbar_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final authErrorHandaler = AuthErrorService();

  String _phoneNumber = '';
  String? _verificationId;

  bool _isSignInLoading = false;
  bool get isSignInLoading => _isSignInLoading;

  bool _isOtpLoading = false;
  bool get isOtpLoading => _isOtpLoading;

  int _resendCooldownTime = 0;
  int get resendCooldownTime => _resendCooldownTime;

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

  void updateSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
    debugPrint(
        '--- AuthProvider: Selected country updated to: ${country.name} ---');
  }

  void setSignInLoading(bool value) {
    _isSignInLoading = value;
    notifyListeners();
    debugPrint('--- AuthProvider: Loading state set to: $value ---');
  }

  void setOtpLoading(bool value) {
    _isOtpLoading = value;
    notifyListeners();
    debugPrint('--- AuthProvider: Loading state set to: $value ---');
  }

  void showError(FirebaseAuthException? e) {
    notifyListeners();
    debugPrint(
        '--- AuthProvider: Error code : ${e?.code} \n message : ${e?.message} ---');
  }

  void startResendCooldown() {
    _resendCooldownTime = 30;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldownTime <= 0) {
        timer.cancel();
        _resendCooldownTime = 0;
      } else {
        _resendCooldownTime--;
      }
      notifyListeners();
    });
  }

  Future<void> startPhoneVerification({
    required BuildContext context,
    required String phoneNumber,
    bool pushOtpScreen = true,
  }) async {
    setSignInLoading(true);
    showError(null); // Reset sign-in error code

    if (_phoneNumber == phoneNumber && resendCooldownTime > 0) {
      setSignInLoading(false);
      SnackbarService(context).showSnackBarWithIconMessage(
          icon: Icons.info,
          title:
              "You've reached the OTP limit. Try again in $resendCooldownTime seconds.");
      return;
    }

    debugPrint(
        '--- AuthProvider: Starting phone number verification for: $phoneNumber ---');

    await _authService.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onVerificationCompleted: (PhoneAuthCredential credential) async {
        debugPrint(
            '--- AuthProvider: Verification completed with credential: $credential ---');
        await _authService.auth.signInWithCredential(credential);
      },
      onVerificationFailed: (e) {
        setSignInLoading(false);
        showError(e);
        SnackbarService(context).showSnackBarWithIconMessage(
            icon: Icons.info, title: authErrorHandaler.authError(e.code));
      },
      onCodeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        _phoneNumber = phoneNumber;
        debugPrint(
            '--- AuthProvider: Code sent with verificationId: $verificationId ---');
        pushOtpScreen ? Navigator.pushNamed(context, '/otp') : null;
        startResendCooldown(); // Start cooldown on successful OTP send
        setSignInLoading(false);
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        debugPrint(
            '--- AuthProvider: Code auto retrieval timeout for verificationId: $verificationId ---');
      },
    );
  }

  void resendOtp(BuildContext context) async {
  if (_phoneNumber.isEmpty) {
    SnackbarService(context).showSnackBarWithIconMessage(
        icon: Icons.error, title: 'Phone number is empty.');
    return;
  }
  await startPhoneVerification(
    context: context,
    phoneNumber: _phoneNumber,
    pushOtpScreen: false,
  );
}

Future<void> signInWithOtp(BuildContext context, String otp) async {
  if (_verificationId == null) {
    SnackbarService(context).showSnackBarWithIconMessage(
        icon: Icons.error, title: 'Verification ID is missing.');
    return;
  }
  setOtpLoading(true);
  try {
    await _authService.verifyOtp(
      verificationId: _verificationId!,
      otp: otp,
      onSuccess: () {
        debugPrint('--- AuthProvider: OTP verification successful ---');
        Navigator.pushNamed(context, '/home');
      },
      onError: (e) {
        showError(e);
        SnackbarService(context).showSnackBarWithIconMessage(
            icon: Icons.info, title: authErrorHandaler.authError(e.code));
      },
    );
  } catch (e) {
    debugPrint('--- AuthProvider: Error: $e ---');
  } finally {
    setOtpLoading(false);
  }
}


  @override
  void dispose() {
    super.dispose();
  }
}
