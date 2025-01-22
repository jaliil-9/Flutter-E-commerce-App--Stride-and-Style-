import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/brand.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../models/brand_model.dart';

class JBBrandOverviewCard extends StatelessWidget {
  const JBBrandOverviewCard({
    super.key,
    required this.images,
    required this.brand,
  });

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: JBSizes.spaceBtwItems),
        decoration: BoxDecoration(
          color: JBStyles.cream,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: JBStyles.burnishedGold),
        ),
        child: Column(
          children: [
            // Brand Card
            JBBrand(
              brand: brand.name,
              showBorder: false,
            ),
            const SizedBox(height: JBSizes.spaceBtwItems),

            // Brand Products
            Row(
                children: images
                    .map((image) => JBBrandOverviewImage(image, context))
                    .toList())
          ],
        ),
      ),
    );
  }
}

Widget JBBrandOverviewImage(String image, context) {
  return Expanded(
      child: Container(
    height: 100,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      color: JBStyles.whiteCream,
      borderRadius: BorderRadius.circular(8),
    ),
    child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const CircularProgressIndicator(color: JBStyles.burnishedGold),
        errorWidget: (context, url, error) => const Icon(Icons.error)),
  ));
}
