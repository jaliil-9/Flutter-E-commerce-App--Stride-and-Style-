import 'package:flutter/material.dart';

import '../../../../../utils/constants/style.dart';

class JBSectionHeading extends StatelessWidget {
  const JBSectionHeading({
    super.key,
    required this.headingText,
    this.buttonText = "View All",
    this.showActionButton = true,
    this.onButtonPressed,
  });

  final String headingText;
  final String buttonText;
  final bool showActionButton;
  final void Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headingText,
          style: JBStyles.h2Light,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onButtonPressed,
            child: Text(buttonText, style: JBStyles.bodyLight),
          ),
      ],
    );
  }
}
