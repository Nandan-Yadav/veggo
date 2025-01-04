import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Firebase Auth instance.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Getter for the Firebase Auth instance.
  get auth => _auth;

  /// Verifies the phone number by sending an OTP.
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential credential) onVerificationCompleted,
    required Function(FirebaseAuthException e) onVerificationFailed,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(String verificationId) onCodeAutoRetrievalTimeout,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: onVerificationCompleted,
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      onVerificationFailed(e);
    }
  }

  /// Signs in the user with the provided OTP.
  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
    required Function() onSuccess,
    required Function(FirebaseAuthException e) onError,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }
}