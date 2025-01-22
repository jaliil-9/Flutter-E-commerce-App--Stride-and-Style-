import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/authentication/authentication_repository.dart';
import 'package:stride_style_ecom/data/repositories/orders/order_repository.dart';
import 'package:stride_style_ecom/features/personalization/controllers/address_controller.dart';
import 'package:stride_style_ecom/features/personalization/controllers/payment_method_controller.dart';
import 'package:stride_style_ecom/features/shop/controllers/cart_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/success_payment_screen.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';

import '../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = Get.put(CartController());
  final addressController = Get.put(AddressController());
  final paymentController = Get.put(PaymentMethodController());
  final orderRepo = Get.put(OrderRepository());

  // Fetch user order history
  Future<List<OrderModel>> getchUserOrders() async {
    try {
      final userOrders = await orderRepo.fetchUserOrders();
      return userOrders;
    } catch (e) {
      JBLoaders.warningSnackBar(title: 'Oops..', message: e.toString());
      return [];
    }
  }

  // Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      const CircularProgressIndicator(
        color: JBStyles.burnishedGold,
      );

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: 'Processing',
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod:
              paymentController.selectedPaymentMethod.value.cardNumber,
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList());

      await orderRepo.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(() => const SuccessPaymentScreen());
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
    }
  }
}
