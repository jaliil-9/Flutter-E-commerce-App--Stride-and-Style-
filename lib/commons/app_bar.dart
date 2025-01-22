import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/cart_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/cart_screen.dart';

import '../navigation.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/style.dart';

class JBAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool addNewIcon;
  final bool showProfileIcon;
  final bool showCartIcon;
  final bool showBackArrow;
  final bool showHeartIcon;

  const JBAppBar({
    super.key,
    required this.title,
    this.addNewIcon = false,
    this.showProfileIcon = false,
    this.showCartIcon = false,
    this.showBackArrow = false,
    this.showHeartIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return AppBar(
      automaticallyImplyLeading: showBackArrow,
      backgroundColor: Colors.transparent,
      title: Text(title, style: JBStyles.h1Light),
      actions: [
        if (showHeartIcon)
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        if (addNewIcon)
          IconButton(
              onPressed: () {
                final controller = Get.find<NavigationController>();
                controller.selectedIndex.value = 1;
              },
              icon: const Icon(Icons.add)),
        if (showCartIcon)
          Stack(children: [
            IconButton(
              onPressed: () => Get.to(() => const CartScreen()),
              icon: const Icon(Icons.shopping_cart),
              iconSize: JBSizes.iconMd,
            ),
            Positioned(
                left: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  padding: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                      color: JBStyles.deepNavy,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Obx(
                      () => Text(
                        cartController.noOfCartItems.value.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ))
          ]),
        if (showProfileIcon)
          IconButton(
            onPressed: () {
              final controller = Get.find<NavigationController>();
              controller.selectedIndex.value = 3;
            },
            icon: const Icon(Icons.account_circle),
            iconSize: JBSizes.iconMd,
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
