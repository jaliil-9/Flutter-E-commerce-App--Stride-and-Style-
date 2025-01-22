import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/reviews%20widgets/rating_star_indicator.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                        image: AssetImage("assets/icons/profile_picture.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: JBSizes.spaceBtwItems),
                Text("Marco Reus", style: JBStyles.priceLight),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),

        const SizedBox(height: JBSizes.spaceBtwItems),

        // Review
        Row(
          children: [
            const JBRatingStarIndicator(rating: 4.0),
            const SizedBox(
              width: JBSizes.spaceBtwItems,
            ),
            Text('09 Oct, 2024', style: JBStyles.bodyLight),
          ],
        ),
        const SizedBox(height: JBSizes.spaceBtwItems),
        const ReadMoreText(
          "Absolutely in love with my new leather boots from Stride & Style! The quality is exceptional—the premium leather feels luxurious and durable, while the modern design adds a chic touch to every outfit. They’re surprisingly comfortable too, perfect for all-day wear. These boots are worth every penny and have quickly become my go-to footwear. Highly recommend!",
          trimLines: 2,
          trimExpandedText: "show less",
          trimCollapsedText: "show more",
          trimMode: TrimMode.Line,
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: JBStyles.deepNavy),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: JBStyles.deepNavy),
        ),

        const SizedBox(
          height: JBSizes.spaceBtwItems,
        ),

        // Admin Review
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: JBStyles.coolGray.withOpacity(0.4)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Stride & Style", style: JBStyles.priceLight),
                  const Text(
                    "11 Oct, 2024",
                  ),
                ],
              ),
              const SizedBox(height: JBSizes.spaceBtwItems),
              const ReadMoreText(
                "Thank you so much for your positive feedback, we're happy to deliver the best quality expected by our clients!",
                trimLines: 2,
                trimExpandedText: "show less",
                trimCollapsedText: "show more",
                trimMode: TrimMode.Line,
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: JBStyles.deepNavy),
                lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: JBStyles.deepNavy),
              ),
            ],
          ),
        )
      ],
    );
  }
}
