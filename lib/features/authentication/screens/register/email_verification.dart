import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/authentication/controllers/register/verify_email.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
        backgroundColor: JBStyles.cream,
        appBar: AppBar(
          backgroundColor: JBStyles.cream,
        ),
        body: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mail sent image
                const Image(
                    image: AssetImage("assets/illustrations/message_sent.png"),
                    height: 300,
                    width: 300),
                const SizedBox(height: JBSizes.spaceBtwSections),

                // Text Message
                Center(
                  child: Text(
                    email ?? '',
                    style: JBStyles.bodyLight,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: JBSizes.spaceBtwItems),

                // Text Message
                Center(
                  child: Text(
                    "Verification e-mail sent! check your inbox to verify.",
                    style: JBStyles.h2Light,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: JBSizes.spaceBtwSections),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.checkEmailVerification();
                      },
                      style: JBStyles.primaryButtonStyle(context),
                      child: const Text("Continue")),
                ),
                const SizedBox(height: JBSizes.spaceBtwItems),

                // Re-send Email Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.sendEmailVerification();
                      },
                      style: JBStyles.secondaryButtonStyle(context),
                      child: const Text("Re-send")),
                )
              ],
            ),
          ),
        ));
  }
}
