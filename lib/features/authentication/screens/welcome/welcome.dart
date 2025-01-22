import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stride_style_ecom/features/authentication/screens/login/login_page.dart';
import 'package:stride_style_ecom/features/authentication/screens/register/register_page.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                // Welcoming Image
                const Image(
                    image: AssetImage("assets/illustrations/class_man.png"),
                    height: 400),

                // Welcoming Text
                const SizedBox(height: JBSizes.spaceBtwItems),
                Center(
                  child: Text("Step into Style with Every Step",
                      style: JBStyles.h1Light, textAlign: TextAlign.center),
                ),

                const SizedBox(height: JBSizes.spaceBtwItems),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: JBSizes.fontSizeMd),
                    child: Text(
                        "Discover premium footwear for every occasion, from casual sneakers to elegant classics",
                        style: JBStyles.bodyLight,
                        textAlign: TextAlign.center),
                  ),
                ),

                // Getting Started & Sign In
                const SizedBox(height: JBSizes.spaceBtwSections),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        final storage = GetStorage();
                        Get.to(() => const RegisterScreen());
                        storage.write('isFirstTime', false);
                      },
                      style: JBStyles.primaryButtonStyle(context),
                      child: const Text("Get Started"),
                    )),
                    const SizedBox(
                      width: JBSizes.spaceBtwItems,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      style: JBStyles.secondaryButtonStyle(context),
                      child: const Text("Sign In"),
                    ))
                  ],
                )
              ])),
        ));
  }
}
