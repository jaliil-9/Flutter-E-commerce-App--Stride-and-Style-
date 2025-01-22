import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBRatingShareTag extends StatelessWidget {
  const JBRatingShareTag({
    super.key,
    required this.rating,
    required this.number,
  });

  final String rating, number;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          children: [
            const Icon(Icons.star, color: JBStyles.burnishedGold, size: 24),
            const SizedBox(
              width: JBSizes.spaceBtwItems / 2,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: rating, style: JBStyles.priceLight),
              TextSpan(text: ' ($number)')
            ]))
          ],
        ),

        // Share
        const Icon(
          Icons.share,
          size: 24,
        )
      ],
    );
  }
}
