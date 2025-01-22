import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/navigation.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: JBStyles.cream,
        appBar: AppBar(
          backgroundColor: JBStyles.cream,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const NavigationMenu());
              },
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Image(
                  image: AssetImage("assets/illustrations/confirmed.png"),
                  height: 300,
                  width: 300),
              const SizedBox(height: JBSizes.spaceBtwSections),

              // Success messsage
              Center(
                child: Text(
                  "Email verified successfully! now let's start shopping.",
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
                      Get.to(() => const NavigationMenu());
                    },
                    style: JBStyles.primaryButtonStyle(context),
                    child: const Text("Continue")),
              ),
            ]),
          ),
        ));
  }
}
