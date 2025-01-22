import 'package:flutter/material.dart';

import '../../../../../utils/constants/style.dart';

class JBBrand extends StatelessWidget {
  const JBBrand({
    super.key,
    required this.brand,
    this.showBorder = true,
    this.onTap,
  });

  final String brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: showBorder ? Border.all(color: JBStyles.deepNavy) : null),
          child: Row(
            children: [
              Text(
                brand,
                style: JBStyles.bodyLight,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(width: 3),
              const Icon(
                Icons.verified,
                size: 15,
                color: JBStyles.deepNavy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
