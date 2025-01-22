import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_style_ecom/features/authentication/controllers/register/register_controller.dart';
import 'package:stride_style_ecom/features/authentication/screens/login/login_page.dart';
import 'package:stride_style_ecom/features/authentication/screens/widgets/google_signin.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import 'package:stride_style_ecom/utils/helpers/validation.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: JBStyles.cream,
      body: Padding(
        padding: const EdgeInsets.all(JBSizes.defaultSpace),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome message
            Text(
              "Hello there! welcome among us.",
              style: JBStyles.h2Light,
            ),
            const SizedBox(height: JBSizes.spaceBtwSections),

            // Login Form
            Form(
              key: controller.signupFormKey,
              child: Column(children: [
                Row(
                  children: [
                    // First Name
                    Expanded(
                      child: TextFormField(
                          controller: controller.firstname,
                          validator: (value) {
                            print("Validating First Name: $value");
                            JBValidator.validateEmptyText("First name", value);
                            return null;
                          },
                          decoration: JBStyles.inputDecoration(context,
                              labelText: "First name",
                              prefixIcon: const Icon(Icons.person))),
                    ),

                    const SizedBox(width: JBSizes.spaceBtwInputFields),

                    // Last Name
                    Expanded(
                      child: TextFormField(
                          controller: controller.lastname,
                          validator: (value) {
                            print("Validating Last Name: $value");
                            JBValidator.validateEmptyText("Last name", value);
                            return null;
                          },
                          decoration: JBStyles.inputDecoration(context,
                              labelText: "Last name",
                              prefixIcon: const Icon(Icons.person))),
                    ),
                  ],
                ),

                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Email
                TextFormField(
                    controller: controller.email,
                    validator: (value) {
                      print("Validating Email: $value");
                      JBValidator.validateEmail(value);
                      return null;
                    },
                    decoration: JBStyles.inputDecoration(context,
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email))),
                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Phone Number
                TextFormField(
                    controller: controller.phonenumber,
                    validator: (value) {
                      print("Validating Phone Number: $value");
                      JBValidator.validatePhoneNumber(value);
                      return null;
                    },
                    decoration: JBStyles.inputDecoration(context,
                        labelText: "Phone number",
                        prefixIcon: const Icon(Icons.local_phone))),
                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Password
                Obx(
                  () => TextFormField(
                      controller: controller.password,
                      validator: (value) {
                        JBValidator.validatePassword(value);
                        return null;
                      },
                      obscureText: controller.hidePassword.value,
                      decoration: JBStyles.inputDecoration(
                        context,
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: Icon(controller.hidePassword.value
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye)),
                      )),
                ),
                const SizedBox(height: JBSizes.spaceBtwSections),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.signup();
                      },
                      style: JBStyles.primaryButtonStyle(context),
                      child: const Text("Sign up")),
                )
              ]),
            ),

            // Register option
            const SizedBox(height: JBSizes.spaceBtwSections),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Already a member?", style: JBStyles.bodyLight),
              GestureDetector(
                  onTap: () {
                    // Navigate to register page
                    Get.to(() => const LoginScreen());
                  },
                  child: Text(
                    "  Login now",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: JBStyles.deepNavy,
                    ),
                  )),
            ]),

            // Divider
            const SizedBox(height: JBSizes.spaceBtwSections),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: JBSizes.defaultSpace),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: JBStyles.coolGray,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Or"),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      color: JBStyles.coolGray,
                    ),
                  )
                ],
              ),
            ),

            // Google Sign in
            const SizedBox(height: JBSizes.spaceBtwSections),
            GoogleSignInCard(onTap: () => controller.googleSignIn())
          ],
        )),
      ),
    );
  }
}
