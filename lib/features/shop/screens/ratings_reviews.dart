import 'package:flutter/material.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/reviews%20widgets/overall_rating.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/reviews%20widgets/rating_star_indicator.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/reviews%20widgets/user_review_card.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../utils/constants/sizes.dart';

class RatingsReviewsScreen extends StatelessWidget {
  const RatingsReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: const JBAppBar(
        title: "Reviews",
        showBackArrow: true,
      ),

      // Body
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(JBSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ratings and Reviews are accurate and from verified users",
              style: JBStyles.bodyLight,
            ),
            const SizedBox(
              height: JBSizes.spaceBtwItems,
            ),

            // Overall Rating
            const JBOverallRating(),
            const JBRatingStarIndicator(
              rating: 4.5,
            ),
            Text('57', style: JBStyles.priceLight),
            const SizedBox(height: JBSizes.spaceBtwSections),

            // Users Reviews
            const UserReviewCard()
          ],
        ),
      )),
    );
  }
}
