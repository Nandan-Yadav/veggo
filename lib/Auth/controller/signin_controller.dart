import 'package:flutter/material.dart';

/// Controller for managing the state of the phone number text field in the sign-in screen.
class SignInPhoneFieldController with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  bool isPhoneFocused = false;

  SignInPhoneFieldController() {
    // Listener to update the focus state of the phone text field
    phoneFocusNode.addListener(() {
      isPhoneFocused = phoneFocusNode.hasFocus;
      debugPrint(
          '--- SignInPhoneFieldController: isPhoneFocused = $isPhoneFocused ---');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to free up resources
    phoneController.dispose();
    phoneFocusNode.dispose();
    debugPrint('--- SignInPhoneFieldController: disposed ---');
    super.dispose();
  }
}

/// Controller for managing the state of the checkbox in the sign-in screen.
class SignInCheckboxStateController with ChangeNotifier {
  bool isChecked = false;
  bool showError = false;

  /// Toggle the checkbox state and update the error state accordingly.
  void toggleCheckbox(bool value) {
    isChecked = value;
    showError = !value; // Show error if checkbox is not checked
    debugPrint(
        '--- SignInCheckboxStateController: isChecked = $isChecked, showError = $showError ---');
    notifyListeners();
  }

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
  void onSubmitForm(GlobalKey<FormState> formKey, BuildContext context) {
    debugPrint('--- SignInCheckboxStateController: onSubmitForm called ---');
    if (formKey.currentState?.validate() ?? false) {
      debugPrint('--- SignInCheckboxStateController: Form validation Success ---');
      validateCheckbox();
      if (isChecked) {
        Navigator.pushNamed(context, '/otp');
      }
    } else {
      // Handle validation failure
      debugPrint('--- SignInCheckboxStateController: Form validation failed ---');
      validateCheckbox();
    }
    notifyListeners();
  }
}
