import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  // Variables
  RxString selectedProductImage = ''.obs;

  // Get all images from product and variations
  List<String> getAllProductImages(ProductModel product) {
    // Add only unique images
    Set<String> images = {};

    // Load thumbnail image
    images.add(product.thumbnail);

    // Assign thumbnail as selected image using post frame callback
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (selectedProductImage.isEmpty) {
        selectedProductImage.value = product.thumbnail;
      }
    });

    // Get all images from the product model
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Get variation images if not null
    if (product.productVariations != null) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  // Show image popup
  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: JBSizes.defaultSpace * 2,
                        horizontal: JBSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  const SizedBox(height: JBSizes.spaceBtwSections),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text(
                            "Close",
                            style: TextStyle(color: JBStyles.deepNavy),
                          )),
                    ),
                  )
                ],
              ),
            ));
  }
}
