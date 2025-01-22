import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stride_style_ecom/features/authentication/controllers/login/login_controller.dart';
import 'package:stride_style_ecom/features/authentication/screens/login/forget_password.dart';
import 'package:stride_style_ecom/features/authentication/screens/register/register_page.dart';
import 'package:stride_style_ecom/features/authentication/screens/widgets/google_signin.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import 'package:stride_style_ecom/utils/helpers/validation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: JBStyles.cream,
      body: Padding(
        padding: const EdgeInsets.all(JBSizes.defaultSpace),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome message
            const Image(
                image: AssetImage("assets/illustrations/welcome.png"),
                height: 100,
                width: 100),
            const SizedBox(height: JBSizes.spaceBtwItems),
            Text(
              "Welcome back! you've been missed.",
              style: JBStyles.h2Light,
            ),
            const SizedBox(height: JBSizes.spaceBtwSections),

            // Login Form
            Form(
              key: controller.loginFormKey,
              child: Column(children: [
                // Email
                TextFormField(
                    controller: controller.email,
                    validator: (value) => JBValidator.validateEmail(value),
                    decoration: JBStyles.inputDecoration(context,
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email))),
                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Password
                Obx(
                  () => TextFormField(
                      controller: controller.password,
                      validator: (value) {
                        JBValidator.validateEmptyText('Password', value);
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
                const SizedBox(height: JBSizes.spaceBtwItems / 6),

                // Remember me & Forgot Password
                Row(
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(-12, 0),
                          child: Obx(
                            () => Checkbox(
                              value: controller.rememberMe.value,
                              activeColor: JBStyles.deepNavy,
                              onChanged: (value) => controller.rememberMe
                                  .value = !controller.rememberMe.value,
                            ),
                          ),
                        ),
                        Transform.translate(
                            offset: const Offset(-16, 0),
                            child:
                                Text("Remember Me", style: JBStyles.bodyLight))
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgetPasswordScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: JBStyles.deepNavy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: JBSizes.spaceBtwItems),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.signIn(),
                      style: JBStyles.primaryButtonStyle(context),
                      child: const Text("Login")),
                )
              ]),
            ),

            // Register option
            const SizedBox(height: JBSizes.spaceBtwSections),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Don't have an account?", style: JBStyles.bodyLight),
              GestureDetector(
                  onTap: () {
                    // Navigate to register page
                    Get.to(() => const RegisterScreen());
                  },
                  child: Text(
                    "  Register now",
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
            GoogleSignInCard(onTap: () => controller.googleSignIn()),
          ],
        )),
      ),
    );
  }
}
