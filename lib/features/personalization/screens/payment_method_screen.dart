import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/personalization/controllers/payment_method_controller.dart';
import 'package:stride_style_ecom/features/personalization/screens/payment/payment_method_card.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

    return Scaffold(
      backgroundColor: JBStyles.cream,

      // Add New Adress Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewPaymentMethod()),
        backgroundColor: JBStyles.deepNavy,
        child: const Icon(
          Icons.add,
          color: JBStyles.whiteCream,
        ),
      ),

      // AppBar
      appBar: const JBAppBar(
        title: "Payment Methods",
        showBackArrow: true,
      ),

      // Addresses
      body: Padding(
        padding: const EdgeInsets.all(JBSizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.allUserMethods(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: JBStyles.burnishedGold));
                }
                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return Center(
                    child:
                        Text('No data available!', style: JBStyles.priceLight),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong!',
                        style: JBStyles.priceLight),
                  );
                }
                final methods = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: methods.length,
                  itemBuilder: (_, index) => JBAPaymentMethodCard(
                      method: methods[index],
                      onTap: () =>
                          controller.selectPaymentMethod(methods[index])),
                );
              }),
        ),
      ),
    );
  }
}

class AddNewPaymentMethod extends StatelessWidget {
  const AddNewPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController.instance);

    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: const JBAppBar(
        title: "Add Payment Method",
        showBackArrow: true,
      ),

      // Payment Method Form
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Form(
            key: controller.paymentMethodFormKey,
            child: Column(
              children: [
                // Car Holder Name Textfield
                TextFormField(
                  controller: controller.cardHolderName,
                  decoration: JBStyles.inputDecoration(context,
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Cardholder Name'),
                ),
                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Card number Textfield
                TextFormField(
                  controller: controller.cardNumber,
                  decoration: JBStyles.inputDecoration(context,
                      prefixIcon: const Icon(Icons.payment),
                      labelText: 'Card number'),
                ),
                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Expiry date & Security code Textfield
                Row(
                  children: [
                    // Expiry date Textfield
                    Expanded(
                      child: TextFormField(
                        controller: controller.expiryDate,
                        decoration: JBStyles.inputDecoration(context,
                            prefixIcon: const Icon(Icons.date_range_outlined),
                            labelText: 'Expiry date'),
                      ),
                    ),
                    const SizedBox(width: JBSizes.spaceBtwInputFields),

                    // Security Code Textfield
                    Expanded(
                      child: TextFormField(
                        controller: controller.securityCode,
                        decoration: JBStyles.inputDecoration(context,
                            prefixIcon: const Icon(Icons.password),
                            labelText: 'Security code'),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: JBSizes.spaceBtwSections,
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewPaymentMethod(),
                    style: JBStyles.primaryButtonStyle(context),
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
