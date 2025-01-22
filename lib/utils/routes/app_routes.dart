import 'package:get/get.dart';
import 'package:stride_style_ecom/features/personalization/screens/adresses.dart';
import 'package:stride_style_ecom/features/shop/screens/orders.dart';
import 'package:stride_style_ecom/features/personalization/screens/profile_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/cart_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/favourite_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/home_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/review_order.dart';
import 'package:stride_style_ecom/features/shop/screens/store_screen.dart';
import 'package:stride_style_ecom/utils/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: JBRoutes.home, page: () => const HomePageScreen()),
    GetPage(name: JBRoutes.store, page: () => const StorePageScreen()),
    GetPage(name: JBRoutes.favourite, page: () => const FavouritePageScreen()),
    GetPage(name: JBRoutes.settings, page: () => const ProfilePageScreen()),
    GetPage(name: JBRoutes.cart, page: () => const CartScreen()),
    GetPage(name: JBRoutes.order, page: () => const OrdersScreen()),
    GetPage(name: JBRoutes.checkout, page: () => const ReviewOrderScreen()),
    GetPage(name: JBRoutes.userAddress, page: () => const AddressesScreen()),
  ];
}
