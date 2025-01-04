import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veggo/Auth/view_model/login_view_model.dart';
import 'package:veggo/Auth/widgets/custom_form_field.dart';
import 'package:veggo/Auth/widgets/custom_image.dart';
import 'package:veggo/data/auth_data.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';
import 'package:veggo/utilities/validators/text_field_validation.dart';
import 'package:veggo/Auth/widgets/custom_country_picker_theme.dart';

class SignInScreenView extends StatefulWidget {
  const SignInScreenView({super.key});

  @override
  _SignInScreenViewState createState() => _SignInScreenViewState();
}

class _SignInScreenViewState extends State<SignInScreenView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              CustomImage(
                imagePath: AuthData.signInSrc,
                width: double.infinity,
                height: DeviceUtilities.deviceHight(context) * 0.2,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: CSizes.spaceBtSections),
              Text(
                AuthData.signInTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.paddingSm),
              Text(AuthData.signInDescription),
              const SizedBox(height: CSizes.spaceBtSections),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      validator: TextFieldValidation.validatePhoneNumber,
                      prefix: Consumer<LoginViewModel>(
                        builder: (context, loginViewModel, child) {
                          return InkWell(
                            onTap: () {
                              CustomCountryPicker.showCountryPickerDialog(
                                context: context,
                                onSelect: (Country country) {
                                  loginViewModel.updateSelectedCountry(country);
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '${loginViewModel.selectedCountry.flagEmoji} +${loginViewModel.selectedCountry.phoneCode}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: CSizes.fontSizeLg),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: CSizes.spaceBtSections),
                    Consumer<LoginViewModel>(
                      builder: (context, loginViewModel, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                    loginViewModel.isLoading
                                        ? CColors.primary
                                        : Colors.grey,
                              ),
                              onPressed: loginViewModel.isLoading
                                  ? null
                                  : () {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        final phoneNumber =
                                            '+${loginViewModel.selectedCountry.phoneCode}${phoneNumberController.text.trim()}';
                                        loginViewModel.startPhoneVerification(
                                            phoneNumber, context);
                                      }
                                    },
                              child: loginViewModel.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Send OTP'),
                            ),
                          ],
                        );
                      },
                    ),
                    Consumer<LoginViewModel>(
                      builder: (context, loginViewModel, child) {
                        if (loginViewModel.loginerrorCode != null) {
                          return Text(
                            loginViewModel.loginerrorCode!,
                            style: const TextStyle(color: Colors.red),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
