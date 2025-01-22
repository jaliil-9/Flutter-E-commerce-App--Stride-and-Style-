import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/screens/orders.dart';
import 'package:stride_style_ecom/navigation.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: JBStyles.cream,
        appBar: AppBar(
          backgroundColor: JBStyles.cream,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Get.to(() => const NavigationMenu()),
                icon: const Icon(Icons.close))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Image(
                  image: AssetImage("assets/illustrations/succ_payment.png"),
                  height: 300,
                  width: 300),
              const SizedBox(height: JBSizes.spaceBtwSections),

              // Success messsage
              Center(
                child: Text(
                  "Payment Success! your shoes will be shipped soon..",
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
                      Get.to(() => const OrdersScreen());
                    },
                    style: JBStyles.primaryButtonStyle(context),
                    child: const Text("Continue")),
              ),
            ]),
          ),
        ));
  }
}
