import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veggo/Auth/view_model/auth_view_model.dart';
import 'package:veggo/Auth/widgets/custom_image.dart';
import 'package:veggo/data/auth_data.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';
import 'package:veggo/utilities/validators/text_field_validation.dart';
import 'package:veggo/Auth/widgets/custom_country_picker_theme.dart';

class SignInScreenView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();

  SignInScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              // Header Image
              CustomImage(
                imagePath: AuthData.signInSrc,
                width: double.infinity,
                height: DeviceUtilities.deviceHight(context) * 0.2,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: CSizes.spaceBtSections),

              // Title
              Text(
                AuthData.signInTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.paddingSm),

              // Subtitle
              Text(
                AuthData.signInDescription,
              ),
              const SizedBox(height: CSizes.spaceBtSections),

              // Phone Number Form
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // Phone Number Input with Country Selector
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: CSizes.fontSizeMd,
                            ),
                            hintText:  'Enter your phone number',
                            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: CSizes.fontSizeMd,
                            ),
                        prefixIcon: Consumer<AuthViewModel>(
                          builder: (context, authViewModel, child) {
                            return InkWell(
                              onTap: () {
                                CustomCountryPicker.showCountryPickerDialog(
                                  context: context,
                                  onSelect: (Country country) {
                                    authViewModel
                                        .updateSelectedCountry(country);
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  '${authViewModel.selectedCountry.flagEmoji} +${authViewModel.selectedCountry.phoneCode}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: CSizes.fontSizeLg),
                                ),
                              ),
                            );
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: CSizes.fontSizeLg,
                          ),
                      keyboardType: TextInputType.phone,
                      validator: TextFieldValidation.validatePhoneNumber,
                    ),
                    const SizedBox(height: CSizes.spaceBtSections),

                    // Submit Button
                    Selector<AuthViewModel, bool>(
                      selector: (_, authViewModel) => authViewModel.isLoading,
                      builder: (context, isLoading, _) {
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    final authViewModel =
                                        Provider.of<AuthViewModel>(
                                      context,
                                      listen: false,
                                    );
                                    final phoneNumber =
                                        '+${authViewModel.selectedCountry.phoneCode}${phoneNumberController.text.trim()}';
                                    authViewModel
                                        .startPhoneVerification(phoneNumber);
                                  }
                                },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text('Send OTP'),
                        );
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
