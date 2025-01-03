import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:veggo/Auth/controller/auth_provider.dart';
import 'package:veggo/Auth/view_model/auth_view_model.dart';
import 'package:veggo/Auth/widgets/custom_image.dart';
import 'package:veggo/data/auth_data.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';
import 'package:veggo/utilities/validators/text_field_validation.dart';

class OtpScreenView extends StatelessWidget {
  final String verificationId;
  OtpScreenView({super.key, required this.verificationId});

  final TextEditingController pinPutController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('--- OtpScreenView: build method called ---');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Custom Image Widget
              CustomImage(
                imagePath: AuthData.otpSrc,
                width: double.infinity,
                height: DeviceUtilities.deviceHight(context) * .2,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: CSizes.spaceBtSections),

              // Title
              Text(
                AuthData.otpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.paddingSm),

              // Description
              Text(
                AuthData.otpDescription,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtSections),
              // OTP Form
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      // PinPut OTP Field
                      Pinput(
                        length: 6,
                        autofocus: true,
                        showCursor: true,
                        forceErrorState: true,
                        controller: pinPutController,
                        closeKeyboardWhenCompleted: false,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        validator: (value) {
                          return TextFieldValidation.validateOtp(value);
                        },
                        defaultPinTheme: customPinTheme(context: context),
                        focusedPinTheme:
                            customPinTheme(context: context, borderwidth: 2.3),
                        submittedPinTheme:
                            customPinTheme(context: context, borderwidth: 2.3),
                        onCompleted: (String verificationCode) {
                          debugPrint('onCompleted: $verificationCode');
                        },
                        onChanged: (code) {
                          debugPrint('onChanged: $code');
                          pinPutController.text = code.trim();
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 2,
                              color: CColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),

              const SizedBox(height: CSizes.spaceBtSections),

              // ElevatedButton
              Selector<AuthViewModel, bool>(
                selector: (_, authViewModel) => authViewModel.isLoading,
                builder: (context, isLoading, child) {
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            final authViewModel = 
                                Provider.of<AuthViewModel>(context, listen: false);
                            authViewModel.verifyOtp(
                              pinPutController.text.trim(),
                              () => Navigator.pushReplacementNamed(context, '/home'),
                            );
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Verify OTP'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PinTheme customPinTheme(
      {required BuildContext context, double borderwidth = 1.5}) {
    return PinTheme(
      width: 54.0,
      height: 58.0,
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 24,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CColors.primary,
          width: borderwidth,
        ),
      ),
    );
  }
}
