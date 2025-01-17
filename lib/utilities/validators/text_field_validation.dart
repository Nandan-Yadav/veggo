class TextFieldValidation {
  // Validate Name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  // Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validate Phone Number
  static String? validatePhoneNumber(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your Phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!isValidPhoneNumber(value)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  // Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Validate Confirm Password
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateOtp(String? value) {
  value = value?.trim();
  if (value == null || value.isEmpty) {
    return 'Please enter the OTP';
  }
  if (value.length != 6) {
    return 'OTP must be 6 digits';
  }
  if (!isValidOtp(value)) {
    return 'OTP must contain only digits';
  }
  return null;
}

static bool isValidOtp(String str) {
  // Regex to check if the string contains exactly 6 digits
  final regex = RegExp(r'^\d{6}$');
  return regex.hasMatch(str);
}

  
static bool isValidPhoneNumber(String str) {
  // Regex to check if the string contains only digits
  final regex = RegExp(r'^\d{10}$');
  return regex.hasMatch(str);
}
}
