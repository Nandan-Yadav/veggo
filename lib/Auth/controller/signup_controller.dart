import 'package:flutter/material.dart';

/// Controller for managing the state of the name text field in the sign-up screen.
class SignUpNameFieldController with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  bool isNameFocused = false;

  SignUpNameFieldController() {
    // Listener to update the focus state of the name text field
    nameFocusNode.addListener(() {
      isNameFocused = nameFocusNode.hasFocus;
      debugPrint(
          '--- SignUpNameFieldController: isNameFocused = $isNameFocused ---');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to free up resources
    nameController.dispose();
    nameFocusNode.dispose();
    debugPrint('--- SignUpNameFieldController: disposed ---');
    super.dispose();
  }
}

/// Controller for managing the state of the email text field in the sign-up screen.
class SignUpEmailFieldController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  bool isEmailFocused = false;

  SignUpEmailFieldController() {
    // Listener to update the focus state of the email text field
    emailFocusNode.addListener(() {
      isEmailFocused = emailFocusNode.hasFocus;
      debugPrint(
          '--- SignUpEmailFieldController: isEmailFocused = $isEmailFocused ---');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to free up resources
    emailController.dispose();
    emailFocusNode.dispose();
    debugPrint('--- SignUpEmailFieldController: disposed ---');
    super.dispose();
  }
}

/// Controller for managing the state of the phone number text field in the sign-up screen.
class SignUpPhoneFieldController with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  bool isPhoneFocused = false;

  SignUpPhoneFieldController() {
    // Listener to update the focus state of the phone text field
    phoneFocusNode.addListener(() {
      isPhoneFocused = phoneFocusNode.hasFocus;
      debugPrint(
          '--- SignUpPhoneFieldController: isPhoneFocused = $isPhoneFocused ---');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to free up resources
    phoneController.dispose();
    phoneFocusNode.dispose();
    debugPrint('--- SignUpPhoneFieldController: disposed ---');
    super.dispose();
  }
}

/// Controller for managing the state of the checkbox in the sign-up screen.
class SignUpCheckboxStateController with ChangeNotifier {
  bool isChecked = false;
  bool showError = false;

  /// Toggle the checkbox state and update the error state accordingly.
  void toggleCheckbox(bool value) {
    isChecked = value;
    showError = !value; // Show error if checkbox is not checked
    debugPrint(
        '--- SignUpCheckboxStateController: isChecked = $isChecked, showError = $showError ---');
    notifyListeners();
  }

  /// Validate checkbox
  void validateCheckbox() {
    if (isChecked) {
      // Proceed with form submission
      debugPrint(
          '--- SignUpCheckboxStateController: Form checkbox is checked ---');
      showError = false;
    } else {
      // Show error if checkbox is not checked
      showError = true;
      debugPrint(
          '--- SignUpCheckboxStateController: Checkbox is not checked ---');
    }
  }

  /// Handle form submission logic
  void onSubmitForm(GlobalKey<FormState> formKey) {
    debugPrint('--- SignUpCheckboxStateController: onSubmitForm called ---');
    if (formKey.currentState?.validate() ?? false) {
      debugPrint(
          '--- SignUpCheckboxStateController: Form validation Success ---');
      validateCheckbox();
    } else {
      // Handle validation failure
      debugPrint(
          '--- SignUpCheckboxStateController: Form validation failed ---');
      validateCheckbox();
    }
    notifyListeners();
  }
}
