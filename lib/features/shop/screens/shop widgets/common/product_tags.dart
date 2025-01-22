import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../controllers/favourite_controller.dart';

class ProductSaleTag extends StatelessWidget {
  final String discount;
  final EdgeInsets? padding;

  const ProductSaleTag({
    super.key,
    required this.discount,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: padding?.left ?? 10,
      top: padding?.top ?? 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: JBStyles.burnishedGold,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          discount,
          style: JBStyles.secondaryLight.copyWith(
            color: JBStyles.cream,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ProductFavoriteTag extends StatelessWidget {
  final EdgeInsets? padding;
  final String? productId;

  const ProductFavoriteTag({
    super.key,
    this.padding,
    this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());

    return Positioned(
      right: padding?.right ?? 2,
      top: padding?.top ?? 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: JBStyles.whiteCream,
          shape: BoxShape.circle,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Obx(
            () => IconButton(
              onPressed: () => controller.toggleFavoriteProduct(productId!),
              icon: controller.isFavourite(productId!)
                  ? const Icon(
                      Icons.favorite,
                      size: 26,
                    )
                  : const Icon(Icons.favorite_border, size: 26),
              key: ValueKey<bool>(controller.isFavourite(productId!)),
              color: controller.isFavourite(productId!)
                  ? Colors.red
                  : JBStyles.coolGray,
            ),
          ),
        ),
      ),
    );
  }
}

// Helper class to combine both tags
class ProductTags extends StatelessWidget {
  final String? discount;
  final EdgeInsets? padding;
  final String productId;
  final bool? showFav;

  const ProductTags(
      {super.key,
      this.discount,
      this.padding,
      required this.productId,
      this.showFav = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (discount != null)
          ProductSaleTag(
            discount: discount!,
            padding: padding,
          ),
        if (showFav!)
          ProductFavoriteTag(
            productId: productId,
            padding: padding,
          ),
      ],
    );
  }
}
