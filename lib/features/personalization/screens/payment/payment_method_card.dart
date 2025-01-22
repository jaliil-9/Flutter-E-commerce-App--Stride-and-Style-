import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/personalization/controllers/payment_method_controller.dart';
import 'package:stride_style_ecom/features/personalization/models/payment_method_model.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/style.dart';

class JBAPaymentMethodCard extends StatelessWidget {
  const JBAPaymentMethodCard({
    super.key,
    required this.method,
    required this.onTap,
  });

  final PaymentMethodModel method;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = PaymentMethodController.instance;
    return Obx(() {
      final selectedMethodId = controller.selectedPaymentMethod.value.id;
      final selectedMethod = selectedMethodId == method.id;
      return InkWell(
        onTap: onTap,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: JBSizes.spaceBtwItems),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: selectedMethod
                    ? JBStyles.burnishedGold.withOpacity(0.6)
                    : JBStyles.whiteCream,
                border: Border.all(
                    color: selectedMethod
                        ? Colors.transparent
                        : JBStyles.burnishedGold.withOpacity(0.4))),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedMethod ? Icons.done : null,
                    color: selectedMethod ? JBStyles.whiteCream : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.cardHolderName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: JBStyles.priceLight,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      method.cardNumber,
                      style: JBStyles.bodyLight,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Expiry date: ${method.expiryDate} Security code: ***',
                      style: JBStyles.bodyLight,
                    )
                  ],
                )
              ],
            )),
      );
    });
  }
}
