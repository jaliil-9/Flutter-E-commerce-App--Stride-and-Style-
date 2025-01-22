import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/controllers/brand_controller.dart';
import 'package:stride_style_ecom/features/shop/controllers/category_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/home%20widgets/category_card.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/grid_layout_products.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/home%20widgets/overview_slider.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/search_bar.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/vproduct_card.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/product/product_controller.dart';
import 'category_screen.dart';
import 'shop widgets/home widgets/home_image.dart';
import 'shop widgets/common/section_heading.dart';
import 'view all screens/view_all_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final productController = Get.put(ProductController());
    final brandController = Get.put(BrandController());
    return Scaffold(
        backgroundColor: JBStyles.cream,

        // App Bar
        appBar: const JBAppBar(
          title: 'Stride & Style',
          showProfileIcon: true,
          showCartIcon: true,
        ),

        // Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(JBSizes.defaultSpace),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Search Bar
                    const JBSearchBar(),
                    const SizedBox(height: JBSizes.spaceBtwItems),

                    // Home Image
                    const JBHomeImage(),
                    const SizedBox(height: JBSizes.spaceBtwSections),

                    Column(children: [
                      // Categories
                      /// Heading
                      JBSectionHeading(
                          headingText: 'Categories',
                          showActionButton: false,
                          onButtonPressed: () {}),
                      const SizedBox(height: JBSizes.spaceBtwItems),

                      /// Categories List
                      Obx(() {
                        if (categoryController.isLoading.value) {
                          return const CircularProgressIndicator(
                            color: JBStyles.burnishedGold,
                          );
                        }
                        if (categoryController.featuredCategories.isEmpty) {
                          return Center(
                            child: Text(
                              "No Data Available!",
                              style: JBStyles.priceLight,
                            ),
                          );
                        }
                        return SizedBox(
                          height: 90,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                categoryController.featuredCategories.length,
                            itemBuilder: (_, index) {
                              final category =
                                  categoryController.featuredCategories[index];
                              final brand =
                                  brandController.featuredBrands[index];
                              // Category Card
                              return JBCategoryCard(
                                isNetworkImage: true,
                                categoryText: category.name,
                                categoryImage: category.image,
                                onTap: () => Get.to(() => CategoryScreen(
                                      category: category,
                                      brand: brand,
                                    )),
                              );
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: JBSizes.spaceBtwSections),
                    ]),

                    // Products Overview
                    Column(
                      children: [
                        // Get Inspired Slider
                        /// Heading
                        const JBSectionHeading(
                            headingText: "Get Inspired",
                            showActionButton: false),
                        const SizedBox(height: JBSizes.spaceBtwItems),
                        const JBOverviewSlider(),
                        const SizedBox(height: JBSizes.spaceBtwSections),

                        // New Arrivals
                        /// Heading
                        JBSectionHeading(
                            headingText: 'New Arrivals',
                            showActionButton: true,
                            buttonText: 'View All',
                            onButtonPressed: () => Get.to(() => ViewAllScreen(
                                  title: 'New Arrival',
                                  futureMethod: productController
                                      .fetchAllFeaturedProducts(),
                                ))),
                        const SizedBox(height: JBSizes.spaceBtwItems),

                        // Products List
                        Obx(() {
                          if (productController.isLoading.value) {
                            return const CircularProgressIndicator(
                              color: JBStyles.burnishedGold,
                            );
                          }
                          if (productController.featuredProducts.isEmpty) {
                            return Center(
                              child: Text(
                                'No Data Available!',
                                style: JBStyles.priceLight,
                              ),
                            );
                          }
                          return JBGridLayoutProducts(
                              mainAxisExtent: 320,
                              itemCount:
                                  productController.featuredProducts.length,
                              itemBuilder: (_, index) =>
                                  // Product Card
                                  JBVProductCard(
                                    product: productController
                                        .featuredProducts[index],
                                  ));
                        }),
                        const SizedBox(height: JBSizes.spaceBtwSections),

                        // Best Sellers
                        /// Heading
                        JBSectionHeading(
                            headingText: 'Best Sellers',
                            showActionButton: true,
                            buttonText: 'View All',
                            onButtonPressed: () => Get.to(() => ViewAllScreen(
                                title: 'Best Sellers',
                                futureMethod: productController
                                    .fetchAllFeaturedProducts()))),
                        const SizedBox(height: JBSizes.spaceBtwItems),

                        // Products List
                        Obx(() {
                          if (productController.isLoading.value) {
                            return const CircularProgressIndicator(
                              color: JBStyles.burnishedGold,
                            );
                          }
                          if (productController.featuredProducts.isEmpty) {
                            return Center(
                              child: Text(
                                'No Data Available!',
                                style: JBStyles.priceLight,
                              ),
                            );
                          }
                          return JBGridLayoutProducts(
                              mainAxisExtent: 320,
                              itemCount:
                                  productController.featuredProducts.length,
                              itemBuilder: (_, index) =>
                                  // Product Card
                                  JBVProductCard(
                                    product: productController
                                        .featuredProducts[index],
                                  ));
                        }),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
