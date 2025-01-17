class AuthErrorService {

  authError(String errorCode){

    switch (errorCode) {
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection and try again.';
      case 'invalid-phone-number':
        return 'The phone number format is invalid. Please enter a valid phone number.';
      case 'invalid-verification-code':
        return 'The OTP you entered does not match the code sent. Please check and try again.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please try again.';
      case 'quota-exceeded':
        return 'The SMS quota for this project has been exceeded. Please try again later.';
       case 'missing-verification-code':
        return 'The verification code is required. Please enter the code sent to your phone.';
      case 'missing-verification-id':
        return 'The verification ID is required. Please try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'missing-phone-number':
        return 'The phone number is required. Please enter your phone number.';
      case 'captcha-check-failed':
        return 'The reCAPTCHA verification failed. Please try again.';
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
      
      default:
        return 'An unknown error occurred. Please try again.';
    }

  }
}