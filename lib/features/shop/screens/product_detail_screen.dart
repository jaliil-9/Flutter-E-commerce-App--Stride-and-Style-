import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/commons/cream_container.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/features/shop/screens/ratings_reviews.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/product%20detail%20widgets/bottom_add_product.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/product%20detail%20widgets/product_attributes.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/product%20detail%20widgets/product_image_slider.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/product%20detail%20widgets/product_meta_data.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/product%20detail%20widgets/rating_share_tag.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/utils/constants/enums.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../controllers/product/images_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());

    return Scaffold(
        bottomNavigationBar: JBBottomAddProduct(product: product),
        backgroundColor: JBStyles.cream,
        body: SingleChildScrollView(
            child: Column(
          children: [
            // Product Image Slider
            JBCurvedWidget(
                child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        // Main Product Image
                        SizedBox(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(JBSizes.defaultSpace),
                            child: Center(
                              child: Obx(() {
                                final image =
                                    controller.selectedProductImage.value;
                                return GestureDetector(
                                  onTap: () =>
                                      controller.showEnlargedImage(image),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: image,
                                    progressIndicatorBuilder: (_, __, ___) =>
                                        const CircularProgressIndicator(
                                            color: JBStyles.burnishedGold),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),

                        // List of Variations
                        JBProductImageSlider(product: product),

                        //AppBar
                        const JBAppBar(
                          title: '',
                          showBackArrow: true,
                        ),
                      ],
                    ))),

            // Product Details Section
            Padding(
              padding: const EdgeInsets.only(
                  right: JBSizes.defaultSpace,
                  left: JBSizes.defaultSpace,
                  bottom: JBSizes.defaultSpace),
              child: Column(
                children: [
                  ///- Ratings & Share
                  const JBRatingShareTag(
                    rating: '4.8',
                    number: '112',
                  ),
                  const SizedBox(
                    height: JBSizes.spaceBtwItems / 2,
                  ),

                  ///- Price, Title, Stock, & Brand
                  JBProductMetaData(
                    product: product,
                  ),
                  const SizedBox(
                    height: JBSizes.spaceBtwItems,
                  ),

                  ///- Variations
                  if (product.productType ==
                      ProductType.variable.toString().split('.').last)
                    JBProductAttributes(
                      product: product,
                    ),
                  const SizedBox(
                    height: JBSizes.spaceBtwSections,
                  ),

                  /// Order Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: JBStyles.primaryButtonStyle(context),
                        child: const Text("Confirm Order")),
                  ),
                  const SizedBox(
                    height: JBSizes.spaceBtwSections,
                  ),

                  /// Description
                  const JBSectionHeading(
                    headingText: "Description",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: JBSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "show more",
                    trimExpandedText: "show less",
                    moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: JBStyles.deepNavy),
                    lessStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: JBStyles.deepNavy),
                  ),

                  /// Reviews
                  const Divider(),
                  const SizedBox(
                    height: JBSizes.spaceBtwItems,
                  ),
                  JBSectionHeading(
                    headingText: "Reviews (57)",
                    showActionButton: true,
                    onButtonPressed: () =>
                        Get.to(() => const RatingsReviewsScreen()),
                  ),

                  const SizedBox(
                    height: JBSizes.spaceBtwSections,
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
