import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_style_ecom/features/authentication/screens/login/login_page.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class PasswordResetSucc extends StatelessWidget {
  const PasswordResetSucc({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: JBStyles.cream,
        body: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reset Link sent image
                const Image(
                    image: AssetImage("assets/illustrations/mail_sent.png"),
                    height: 300,
                    width: 300),
                const SizedBox(height: JBSizes.spaceBtwSections),

                // Check your inbox text
                Center(
                  child: Text(
                    email,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: JBSizes.spaceBtwSections),

                // Check your inbox text
                Center(
                  child: Text(
                    "Reset link sent! Check your inbox, reset your password, then let's try again!",
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
                        Get.to(() => const LoginScreen());
                      },
                      style: JBStyles.primaryButtonStyle(context),
                      child: const Text("Continue")),
                )
              ],
            ),
          ),
        ));
  }
}
