import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/personalization/controllers/address_controller.dart';
import 'package:stride_style_ecom/features/personalization/controllers/payment_method_controller.dart';
import 'package:stride_style_ecom/features/shop/controllers/cart_controller.dart';
import 'package:stride_style_ecom/features/shop/controllers/order_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/cart%20widgets/promo_code.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';

import '../../../commons/app_bar.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/style.dart';
import 'shop widgets/cart widgets/cart_items_list.dart';

class ReviewOrderScreen extends StatelessWidget {
  const ReviewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final total = controller.totalCartPrice.value + 20 + 6;
    final orderController = Get.put(OrderController());
    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: const JBAppBar(
        title: 'Order Review',
        showBackArrow: true,
      ),

      // Confirm Order Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: total > 0
              ? () => orderController.processOrder(total)
              : JBLoaders.warningSnackBar(
                  title: 'Empty Cart!',
                  message: 'Add items in order to proceed'),
          style: JBStyles.primaryButtonStyle(context),
          child: Text('Confirm Order \$${total.toStringAsFixed(2)}',
              style: JBStyles.buttonLight),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(JBSizes.defaultSpace),
            child: Column(
              children: [
                /// Cart Items
                const JBCartItemsList(
                  showAddRemoveOpt: false,
                ),
                const SizedBox(height: JBSizes.spaceBtwSections * 1.5),

                // Coupon Field
                const JBPromoCode(),
                const SizedBox(height: JBSizes.spaceBtwSections),

                // Billing
                Container(
                    padding: const EdgeInsets.all(JBSizes.defaultSpace),
                    decoration: BoxDecoration(
                        color: JBStyles.whiteCream,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            color: JBStyles.burnishedGold.withOpacity(0.4))),
                    child: const Column(
                      children: [
                        /// Pricing
                        JBBillingPrice(),

                        SizedBox(
                          height: JBSizes.spaceBtwItems,
                        ),
                        Divider(),
                        SizedBox(
                          height: JBSizes.spaceBtwItems,
                        ),

                        /// Payment methods
                        JBBillingPayment(),

                        /// Address
                        JBShippingAddress()
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}

class JBShippingAddress extends StatelessWidget {
  const JBShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JBSectionHeading(
            headingText: 'Address',
            buttonText: 'Change',
            showActionButton: true,
            onButtonPressed: () => controller.selectNewAddressPopup(context),
          ),
          const SizedBox(
            height: JBSizes.spaceBtwItems / 2,
          ),
          controller.selectedAddress.value.id.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.selectedAddress.value.name,
                        style: JBStyles.priceLight),
                    const SizedBox(
                      height: JBSizes.spaceBtwItems / 2,
                    ),
                    // Phone Number
                    Row(
                      children: [
                        const Icon(Icons.local_phone,
                            color: JBStyles.coolGray, size: 16),
                        const SizedBox(
                          height: JBSizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          child: Text(
                            controller.selectedAddress.value.phoneNumber,
                            style: JBStyles.bodyLight,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: JBSizes.spaceBtwItems / 2),

                    // Address
                    Row(
                      children: [
                        const Icon(Icons.home,
                            color: JBStyles.coolGray, size: 16),
                        const SizedBox(
                          height: JBSizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          child: Text(
                            controller.selectedAddress.value.toString(),
                            style: JBStyles.bodyLight,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: JBSizes.spaceBtwItems / 2),
                  ],
                )
              : Text(
                  "Select address",
                  style: JBStyles.priceLight.apply(color: JBStyles.deepNavy),
                ),
        ],
      ),
    );
  }
}

class JBBillingPayment extends StatelessWidget {
  const JBBillingPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JBSectionHeading(
            headingText: 'Payment Method',
            buttonText: 'Change',
            showActionButton: true,
            onButtonPressed: () => controller.selectNewMethodPopup(context),
          ),
          const SizedBox(
            height: JBSizes.spaceBtwItems / 2,
          ),
          controller.selectedPaymentMethod.value.id.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.selectedPaymentMethod.value.cardHolderName,
                        style: JBStyles.priceLight),
                    const SizedBox(
                      height: JBSizes.spaceBtwItems / 2,
                    ),
                    // Card Number
                    Row(
                      children: [
                        const Icon(Icons.local_phone,
                            color: JBStyles.coolGray, size: 16),
                        const SizedBox(
                          height: JBSizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          child: Text(
                            controller.selectedPaymentMethod.value.cardNumber,
                            style: JBStyles.bodyLight,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: JBSizes.spaceBtwItems / 2),

                    // Address
                    Row(
                      children: [
                        const Icon(Icons.home,
                            color: JBStyles.coolGray, size: 16),
                        const SizedBox(
                          height: JBSizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          child: Text(
                            'Expiry date: ${controller.selectedPaymentMethod.value.expiryDate}, Security code: ***',
                            style: JBStyles.bodyLight,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: JBSizes.spaceBtwItems / 2),
                  ],
                )
              : Text(
                  "Select Payment Method",
                  style: JBStyles.priceLight.apply(color: JBStyles.deepNavy),
                ),
        ],
      ),
    );
  }
}

class JBBillingPrice extends StatelessWidget {
  const JBBillingPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;

    return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subtotal",
              style: JBStyles.bodyLight,
            ),
            Text(
              "\$${subTotal.toStringAsFixed(2)}",
              style: JBStyles.bodyLight,
            )
          ],
        ),
        const SizedBox(
          height: JBSizes.spaceBtwItems / 2,
        ),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shipping fee",
              style: JBStyles.bodyLight,
            ),
            Text(
              "\$20",
              style: JBStyles.bodyLight,
            )
          ],
        ),
        const SizedBox(
          height: JBSizes.spaceBtwItems / 2,
        ),

        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax fee",
              style: JBStyles.bodyLight,
            ),
            Text(
              "\$6",
              style: JBStyles.bodyLight,
            )
          ],
        ),
        const SizedBox(
          height: JBSizes.spaceBtwItems / 2,
        ),

        // Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: JBStyles.priceLight,
            ),
            Text(
              "\$${(subTotal + 20 + 6).toStringAsFixed(2)}",
              style: JBStyles.priceLight,
            )
          ],
        ),
      ],
    );
  }
}
