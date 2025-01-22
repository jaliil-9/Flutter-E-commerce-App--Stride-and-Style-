import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBRatingStarIndicator extends StatelessWidget {
  const JBRatingStarIndicator({
    super.key,
    required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (_, __) => const Icon(
        Icons.star,
        color: JBStyles.burnishedGold,
      ),
      rating: rating,
      unratedColor: JBStyles.coolGray.withOpacity(0.5),
      itemSize: 20,
    );
  }
}
