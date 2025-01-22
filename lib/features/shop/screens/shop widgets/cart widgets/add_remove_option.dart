import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBAddRemoveOption extends StatelessWidget {
  const JBAddRemoveOption({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Remove Item Button
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: JBStyles.coolGray.withOpacity(0.4)),
              child: IconButton(
                onPressed: remove,
                icon: const Icon(
                  Icons.remove,
                ),
              ),
            ),
            const SizedBox(
              width: JBSizes.spaceBtwItems,
            ),

            // Count
            Text(
              quantity.toString(),
              style: JBStyles.priceLight,
            ),
            const SizedBox(
              width: JBSizes.spaceBtwItems,
            ),

            // Add Item Button
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: JBStyles.burnishedGold.withOpacity(0.8),
              ),
              child: IconButton(
                onPressed: add,
                icon: const Icon(
                  Icons.add,
                ),
                color: JBStyles.whiteCream,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
