import 'package:flutter/material.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBRatingIndicator extends StatelessWidget {
  const JBRatingIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text, style: JBStyles.priceLight)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.6, // Get Device's Width
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: JBStyles.coolGray.withOpacity(0.5),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(JBStyles.deepNavy),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
      ],
    );
  }
}
