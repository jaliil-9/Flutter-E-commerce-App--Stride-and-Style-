import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/controllers/category_controller.dart';
import 'package:stride_style_ecom/features/shop/models/brand_model.dart';
import 'package:stride_style_ecom/features/shop/models/category_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/hproduct_card.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/features/shop/screens/view%20all%20screens/view_all_screen.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../utils/constants/image_strings.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(
      {super.key, required this.category, required this.brand});

  final CategoryModel category;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: JBAppBar(
        title: category.name,
        showBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              Container(
                height: 200,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Image(
                    image: AssetImage(JBImage.overview3),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: JBSizes.spaceBtwSections,
              ),

              // SubCategory
              FutureBuilder(
                  future: controller.getSubCategories(category.name),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: JBStyles.burnishedGold));
                    }
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('No data available!',
                            style: JBStyles.priceLight),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Something went wrong!',
                            style: JBStyles.priceLight),
                      );
                    }

                    final subCaategories = snapshot.data!;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCaategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCaategories[index];

                          return FutureBuilder(
                              future: controller.getBrandProducts(
                                  brandName: subCategory.name),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text('No data available!',
                                        style: JBStyles.priceLight),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Something went wrong!',
                                        style: JBStyles.priceLight),
                                  );
                                }
                                final products = snapshot.data!;

                                return Column(
                                  children: [
                                    JBSectionHeading(
                                      headingText: subCategory.name,
                                      showActionButton: true,
                                      onButtonPressed: () =>
                                          Get.to(() => ViewAllScreen(
                                                title: subCategory.name,
                                                futureMethod:
                                                    controller.getBrandProducts(
                                                        brandName:
                                                            subCategory.name,
                                                        limit: -1),
                                              )),
                                    ),
                                    const SizedBox(
                                      height: JBSizes.spaceBtwItems / 2,
                                    ),

                                    // Horizontal Product Card
                                    SizedBox(
                                      height: 140,
                                      child: ListView.separated(
                                        itemCount: products.length,
                                        separatorBuilder: (_, index) =>
                                            const SizedBox(
                                          width: JBSizes.spaceBtwItems,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, index) =>
                                            JBHProductCard(
                                          product: products[index],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
