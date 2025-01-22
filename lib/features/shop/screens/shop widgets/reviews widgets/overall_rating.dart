import 'package:flutter/material.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/reviews%20widgets/rating_indicator.dart';

class JBOverallRating extends StatelessWidget {
  const JBOverallRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 3, child: Text('4.8', style: TextStyle(fontSize: 62))),
        Expanded(
          flex: 7,
          child: Column(children: [
            JBRatingIndicator(text: '5', value: 0.8),
            JBRatingIndicator(text: '4', value: 0.5),
            JBRatingIndicator(text: '3', value: 0.2),
            JBRatingIndicator(text: '2', value: 0.1),
            JBRatingIndicator(text: '1', value: 0.1),
          ]),
        )
      ],
    );
  }
}
