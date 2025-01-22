import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/screens/review_order.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/cart%20widgets/cart_items_list.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: const JBAppBar(
        title: 'Cart',
        showBackArrow: true,
      ),

      // Confirm Order Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const ReviewOrderScreen()),
                style: JBStyles.primaryButtonStyle(context),
                child: Obx(() => Text(
                    'Confirm Order \$${controller.totalCartPrice.value.toStringAsFixed(2)}',
                    style: JBStyles.buttonLight)),
              ),
            ),

      // Cart Items
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Text(
              'No Items added yet!',
              style: JBStyles.priceLight,
            ),
          );
        } else {
          return const SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(JBSizes.defaultSpace),
                child: JBCartItemsList()),
          );
        }
      }),
    );
  }
}
