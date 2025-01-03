import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../model/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _verificationId;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Default selected country
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

  // Method to update the selected country
  void updateSelectedCountry(Country country) {
    debugPrint('--- Updating selected country to: ${country.name} ---');
    _selectedCountry = country;
    notifyListeners();
    debugPrint('Selected country updated to: ${country.name}');
  }
  
  Future<void> startPhoneVerification(String phoneNumber) async {
    setLoading(true);
    setErrorMessage(null);

    await _authService.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId) {
        _verificationId = verificationId;
        setLoading(false);
      },
      onError: (message) {
        setErrorMessage(message);
        setLoading(false);
      },
    );
  }

  Future<void> verifyOtp(String otp, VoidCallback onSuccess) async {
    if (_verificationId == null) {
      setErrorMessage('Verification ID is null');
      return;
    }

    setLoading(true);
    await _authService.signInWithOtp(
      verificationId: _verificationId!,
      otp: otp,
      onSuccess: () {
        setLoading(false);
        onSuccess();
      },
      onError: (message) {
        setErrorMessage(message);
        setLoading(false);
      },
    );
  }
}
