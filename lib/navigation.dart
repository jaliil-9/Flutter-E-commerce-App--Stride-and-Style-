import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/screens/favourite_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/home_screen.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';

import 'features/personalization/screens/profile_screen.dart';
import 'features/shop/screens/store_screen.dart';
import 'utils/constants/style.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: JBStyles.cream,
          indicatorColor: Colors.transparent,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home,
                  color: JBStyles.deepNavy, size: JBSizes.iconLg),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              selectedIcon: Icon(Icons.shopping_bag,
                  color: JBStyles.deepNavy, size: JBSizes.iconLg),
              label: 'Store',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline_rounded),
              selectedIcon: Icon(Icons.favorite_rounded,
                  color: JBStyles.deepNavy, size: JBSizes.iconLg),
              label: 'Favourite',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined),
              selectedIcon: Icon(Icons.account_circle,
                  color: JBStyles.deepNavy, size: JBSizes.iconLg),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePageScreen(),
    const StorePageScreen(),
    const FavouritePageScreen(),
    const ProfilePageScreen(),
  ];
}
