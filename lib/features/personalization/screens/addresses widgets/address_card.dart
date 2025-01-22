import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/personalization/controllers/address_controller.dart';
import 'package:stride_style_ecom/features/personalization/models/address_model.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBAddressCard extends StatelessWidget {
  const JBAddressCard({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: JBSizes.spaceBtwItems),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: selectedAddress
                    ? JBStyles.burnishedGold.withOpacity(0.6)
                    : JBStyles.whiteCream,
                border: Border.all(
                    color: selectedAddress
                        ? Colors.transparent
                        : JBStyles.burnishedGold.withOpacity(0.4))),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Icons.done : null,
                    color: selectedAddress ? JBStyles.whiteCream : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: JBStyles.priceLight,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      address.phoneNumber,
                      style: JBStyles.bodyLight,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      address.toString(),
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
