import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/cart_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/cart%20widgets/add_remove_option.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/cart%20widgets/cart_item.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBCartItemsList extends StatelessWidget {
  const JBCartItemsList({
    super.key,
    this.showAddRemoveOpt = true,
  });

  final bool showAddRemoveOpt;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          height: JBSizes.spaceBtwSections,
        ),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];

          return Column(
            children: [
              JBCartItem(cartItem: item),
              if (showAddRemoveOpt)
                const SizedBox(height: JBSizes.spaceBtwItems),
              if (showAddRemoveOpt)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        // Add & Remove Item Options
                        JBAddRemoveOption(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),

                    // Product Price
                    Text("\$${(item.price * item.quantity).toStringAsFixed(2)}",
                        style: JBStyles.priceLight)
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}
