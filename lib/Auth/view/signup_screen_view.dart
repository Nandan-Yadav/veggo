import 'package:flutter/material.dart';
import 'package:veggo/Auth/controller/signup_controller.dart';
import 'package:veggo/Auth/widgets/custom_rich_text.dart';
import 'package:veggo/Auth/widgets/custom_form_field.dart';
import 'package:veggo/Auth/widgets/custom_checkbox.dart';
import 'package:veggo/Auth/widgets/custom_image.dart';
import 'package:veggo/data/auth_data.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';
import 'package:provider/provider.dart';
import 'package:veggo/utilities/validators/text_field_validation.dart';

class SignUpScreenView extends StatelessWidget {
  SignUpScreenView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Custom Image Widget
              CustomImage(
                imagePath: AuthData.signUpSrc,
                width: double.infinity,
                height: DeviceUtilities.deviceHight(context) * .2,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: CSizes.spaceBtSections),

              // Title
              Text(
                AuthData.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.paddingSm),

              // Description
              Text(
                AuthData.signUpDescription,
              ),
              const SizedBox(height: CSizes.paddingSm),

              // Form Fields
              Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: CSizes.spaceBtSections),

                    // Name Field
                    Consumer<SignUpNameFieldController>(
                      builder: (context, controller, child) {
                        return CustomFormField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          label: AuthData.signUpNameFieldLable,
                          icon: Icons.person,
                          validator: TextFieldValidation.validateName,
                          prefixIconColor:
                              controller.isNameFocused ? CColors.primary : null,
                          focusNode: controller.nameFocusNode,
                        );
                      },
                    ),

                    const SizedBox(height: CSizes.spaceBtwInputFields),

                    // Email Field
                    Consumer<SignUpEmailFieldController>(
                      builder: (context, controller, child) {
                        return CustomFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: AuthData.signUpEmailLable,
                          icon: Icons.email,
                          validator: TextFieldValidation.validateEmail,
                          prefixIconColor: controller.isEmailFocused
                              ? CColors.primary
                              : null,
                          focusNode: controller.emailFocusNode,
                        );
                      },
                    ),

                    const SizedBox(height: CSizes.spaceBtwInputFields),

                    // Phone Field
                    Consumer<SignUpPhoneFieldController>(
                      builder: (context, controller, child) {
                        return CustomFormField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          label: AuthData.signUpPhoneLable,
                          icon: Icons.phone,
                          validator: TextFieldValidation.validatePhoneNumber,
                          prefixIconColor: controller.isPhoneFocused
                              ? CColors.primary
                              : null,
                          focusNode: controller.phoneFocusNode,
                        );
                      },
                    ),
                  ],
                ),
              ),

              // CustomCheckbox for T&C acceptance
              Consumer<SignUpCheckboxStateController>(
                  builder: (context, controller, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCheckbox(
                      value: controller.isChecked,
                      onChanged: (value) {
                        controller.toggleCheckbox(value!);
                      },
                      labelText: AuthData.signUpChackBoxDescription,
                      linkText: 'T&C',
                    ),
                    if (controller.showError)
                      const Text(
                        'Please check the box to proceed',
                        style: TextStyle(
                            color: CColors.error, fontWeight: FontWeight.w500),
                      ),
                  ],
                );
              }),

              const SizedBox(height: CSizes.paddingMd),

              // ElevatedButton
              Consumer<SignUpCheckboxStateController>(
                builder: (context, controller, child) {
                  return ElevatedButton(
                    onPressed: () {
                      controller.onSubmitForm(formKey);
                    },
                    child: const Text('Next'),
                  );
                },
              ),

              const SizedBox(height: CSizes.paddingLg),

              // Already have an account text
              RichTexWithTextButton(
                text: AuthData.alreadyHaveAccount,
                linkText: 'Login',
                onLinkTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
