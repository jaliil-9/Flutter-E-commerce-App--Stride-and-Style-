import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBUserParamCard extends StatelessWidget {
  const JBUserParamCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onPressed,
  });

  final String title, value;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: JBSizes.spaceBtwItems / 2),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: JBStyles.priceLight,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: JBStyles.bodyLight,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: 18))
          ],
        ),
      ),
    );
  }
}
