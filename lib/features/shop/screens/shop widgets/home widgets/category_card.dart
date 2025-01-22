import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/style.dart';

class JBCategoryCard extends StatelessWidget {
  const JBCategoryCard({
    super.key,
    required this.categoryText,
    required this.categoryImage,
    this.onTap,
    this.isNetworkImage = false,
  });

  final String categoryText, categoryImage;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: JBSizes.spaceBtwItems + 10),
        child: Column(children: [
          // Category Card Image
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: JBStyles.whiteCream,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
                child: isNetworkImage
                    ? CachedNetworkImage(imageUrl: categoryImage)
                    : Image(
                        image: AssetImage(categoryImage),
                        fit: BoxFit.cover,
                        color: JBStyles.cognacBrown)),
          ),

          // Category Card Text
          const SizedBox(
            height: JBSizes.spaceBtwItems / 2,
          ),
          Flexible(
              child: Text(categoryText,
                  style: JBStyles.bodyLight,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)),
        ]),
      ),
    );
  }
}
