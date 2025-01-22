import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/commons/cream_container.dart';
import 'package:stride_style_ecom/data/repositories/authentication/authentication_repository.dart';
import 'package:stride_style_ecom/features/personalization/screens/adresses.dart';
import 'package:stride_style_ecom/features/personalization/screens/payment_method_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/orders.dart';
import 'package:stride_style_ecom/features/personalization/screens/profile%20widgets/settings_card.dart';
import 'package:stride_style_ecom/features/personalization/screens/profile%20widgets/user_profile_card.dart';
import 'package:stride_style_ecom/features/shop/screens/cart_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../utils/constants/sizes.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return Scaffold(
        backgroundColor: JBStyles.whiteCream,
        // User Profile
        body: SingleChildScrollView(
            child: Column(
          children: [
            // Header
            const JBCreamCont(
                child: Column(
              children: [
                // AppBar
                JBAppBar(title: "Account"),
                SizedBox(height: JBSizes.spaceBtwItems),

                // User Profile Card
                JBUserProfileCard(),
                SizedBox(height: JBSizes.spaceBtwSections)
              ],
            )),

            // Body
            Padding(
              padding: const EdgeInsets.all(JBSizes.defaultSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Section Heading
                  Column(
                    children: [
                      const JBSectionHeading(
                        headingText: "Account Settings",
                        showActionButton: false,
                      ),
                      const SizedBox(height: JBSizes.spaceBtwItems),

                      // Settings Menu
                      JBSettingsCard(
                        title: "My Adresses",
                        subtitle: "Set shopping delivery adresses",
                        icon: Icons.house,
                        onTap: () => Get.to(() => const AddressesScreen()),
                      ),
                      JBSettingsCard(
                        icon: Icons.shopping_cart,
                        title: "My Cart",
                        subtitle:
                            "Add, remove, and move products to confirm orders",
                        onTap: () => Get.to(() => const CartScreen()),
                      ),
                      JBSettingsCard(
                        icon: Icons.receipt,
                        title: "My Orders",
                        subtitle: "Check orders progress",
                        onTap: () => Get.to(() => const OrdersScreen()),
                      ),
                      JBSettingsCard(
                          icon: Icons.payment,
                          title: "Payement Methods",
                          subtitle: "Manage your payement methods",
                          onTap: () =>
                              Get.to(() => const PaymentMethodScreen())),
                    ],
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: JBStyles.cream,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
