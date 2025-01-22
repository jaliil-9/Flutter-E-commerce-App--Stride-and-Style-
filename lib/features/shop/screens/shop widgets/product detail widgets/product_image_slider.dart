import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/product/images_controller.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/curved_edges_image.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';

import '../../../../../utils/constants/style.dart';

class JBProductImageSlider extends StatelessWidget {
  const JBProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return Positioned(
      right: 0,
      bottom: 30,
      left: JBSizes.defaultSpace,
      child: SizedBox(
        height: 80,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(
                  width: JBSizes.spaceBtwItems,
                ),
            itemBuilder: (_, index) {
              return Obx(() {
                final imageSelected =
                    controller.selectedProductImage.value == images[index];
                return CurvedEdgesImage(
                    isNetworkImage: true,
                    onTap: () =>
                        controller.selectedProductImage.value = images[index],
                    width: 80,
                    imageUrl: images[index],
                    border: Border.all(
                        color: imageSelected
                            ? JBStyles.burnishedGold
                            : Colors.transparent));
              });
            }),
      ),
    );
  }
}
