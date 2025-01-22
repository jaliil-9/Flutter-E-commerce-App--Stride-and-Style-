import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import 'package:stride_style_ecom/utils/helpers/validation.dart';

import '../../controllers/login/forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
        backgroundColor: JBStyles.cream,

        // AppBar
        appBar: AppBar(
          backgroundColor: JBStyles.cream,
        ),
        body: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Center(
            child: Column(
              children: [
                // Reset Password Message
                Center(
                  child: Text("Reset your password",
                      style: JBStyles.h1Light, textAlign: TextAlign.center),
                ),

                const SizedBox(height: JBSizes.spaceBtwItems),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: JBSizes.fontSizeMd),
                    child: Text(
                        "Don't worry, we all forget it at some point, we will send you a password reset link to your e-mail",
                        style: JBStyles.bodyLight,
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: JBSizes.spaceBtwSections),

                // Email
                Form(
                  key: controller.forgetPasswordFormKey,
                  child: TextFormField(
                      controller: controller.email,
                      validator: JBValidator.validateEmail,
                      decoration: JBStyles.inputDecoration(context,
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email))),
                ),

                const SizedBox(height: JBSizes.spaceBtwSections),

                // Reset Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.sendPasswordResetEmail();
                      },
                      style: JBStyles.primaryButtonStyle(context),
                      child: const Text("Send Reset Link")),
                )
              ],
            ),
          ),
        ));
  }
}
