import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:veggo/Auth/view_model/otp_view_model.dart';
import 'package:veggo/Auth/widgets/custom_image.dart';
import 'package:veggo/data/auth_data.dart';
import 'package:veggo/utilities/constants/color.dart';
import 'package:veggo/utilities/constants/size.dart';
import 'package:veggo/utilities/devices/device_utilities.dart';
import 'package:veggo/utilities/validators/text_field_validation.dart';

class OtpScreenView extends StatefulWidget {
  final String verificationId;

  const OtpScreenView({super.key, required this.verificationId});

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
                  ],
                ),
              ),
              const SizedBox(height: CSizes.paddingMd),

              // Elevated button to verify OTP.
              Consumer<OtpViewModel>(
                builder: (context, otpViewModel, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: otpViewModel.isLoading
                          ? CColors.primary
                          : Colors.grey,
                    ),
                    onPressed: otpViewModel.isLoading
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              debugPrint(
                                  '--- OtpScreenView: Verify OTP button pressed ---');
                              otpViewModel.signInWithOtp(
                                widget.verificationId,
                                pinPutController.text.trim(),
                                context,
                              );
                            }
                          },
                    child: otpViewModel.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text('Verify OTP'),
                  );
                },
              ),
              Consumer<OtpViewModel>(
                builder: (context, otpViewModel, child) {
                  if (otpViewModel.otpErrorCode != null) {
                    return Text(
                      otpViewModel.otpErrorCode!,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return Container();
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
