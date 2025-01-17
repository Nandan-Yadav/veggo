import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:veggo/Auth/view_model/auth_view_model.dart';
import 'package:veggo/widgets/custom_elevated_button.dart';
import 'package:veggo/widgets/custom_image.dart';
import 'package:veggo/data/auth_data.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';
import 'package:veggo/utilities/validators/text_field_validation.dart';
import 'package:veggo/widgets/custom_text_button.dart';

class OtpScreenView extends StatefulWidget {
  const OtpScreenView({super.key});

  @override
  _OtpScreenViewState createState() => _OtpScreenViewState();
}

class _OtpScreenViewState extends State<OtpScreenView> {
  late TextEditingController pinPutController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pinPutController = TextEditingController();
  }

  @override
  void dispose() {
    pinPutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                imagePath: AuthData.otpSrc,
                width: double.infinity,
                height: DeviceUtilities.deviceHight(context) * .2,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: CSizes.spaceBtSections),
              Text(
                AuthData.otpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.paddingSm),
              Text(
                AuthData.otpDescription,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtSections),
              Form(
                key: formKey,
                child: Column(
                  children: [
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
                        debugPrint(
                            '--- OtpScreenView: OTP entered: $verificationCode ---');
                      },
                      onChanged: (code) {
                        debugPrint('--- OtpScreenView: OTP changed: $code ---');
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
                    const SizedBox(height: CSizes.spaceBtSections),
                    Selector<AuthViewModel, bool>(
                      selector: (_, auth) => auth.isOtpLoading,
                      builder: (context, isLoading, child) {
                        return CustomElevatedButton(
                          buttonStyle: ElevatedButton.styleFrom(
                            disabledBackgroundColor: CColors.primary,
                            disabledForegroundColor: Colors.white,
                          ),
                          onPress: isLoading
                              ? null
                              : () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    debugPrint(
                                        '--- OtpScreenView: Verify OTP button pressed ---');

                                    context.read<AuthViewModel>().signInWithOtp(
                                          context,
                                          pinPutController.text.trim(),
                                        );
                                  }
                                },
                          child: isLoading
                              ? const Row(
                                  spacing: CSizes.defaultSpace,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('Please wait...')
                                  ],
                                )
                              : const Text('Verify OTP'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CSizes.paddingMd),
              Text(
                "Don't receive OTP?",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: CSizes.paddingMd),
              Selector<AuthViewModel, int>(
                selector: (_, auth) => auth.resendCooldownTime,
                builder: (context, cooldown, child) {
                  return CustomTextButton(
                    buttonStyle: TextButton.styleFrom(
                      disabledForegroundColor: Colors.grey,
                      foregroundColor: CColors.primary,
                      overlayColor: Colors.transparent,
                    ),
                    onPress: cooldown > 0
                        ? null
                        : () {
                            context.read<AuthViewModel>().resendOtp(context);
                          },
                    child: cooldown > 0
                        ? Text('Resend OTP in $cooldown seconds')
                        : const Text('Resend OTP'),
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
