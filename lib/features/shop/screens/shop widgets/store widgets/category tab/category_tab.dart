import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/category_controller.dart';
import 'package:stride_style_ecom/features/shop/models/category_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/grid_layout_products.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/vproduct_card.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/category%20tab/category_brands.dart';
import 'package:stride_style_ecom/features/shop/screens/view%20all%20screens/view_all_screen.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';

import '../../../../../../utils/constants/style.dart';

class JBCategoryTab extends StatelessWidget {
  const JBCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
              padding: const EdgeInsets.all(JBSizes.defaultSpace),
              child: Column(
                children: [
                  // Brand Overview Card
                  CategoryBrands(category: category),
                  const SizedBox(height: JBSizes.spaceBtwSections),

                  // Products
                  FutureBuilder(
                      future: controller.getCategoryProducts(
                          categoryId: category.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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

                        final products = snapshot.data!;

                        return Column(
                          children: [
                            JBSectionHeading(
                                headingText: "You Might Like",
                                showActionButton: true,
                                onButtonPressed: () => Get.to(ViewAllScreen(
                                      title: category.name,
                                      futureMethod:
                                          controller.getCategoryProducts(
                                              categoryId: category.id,
                                              limit: -1),
                                    ))),
                            const SizedBox(height: JBSizes.spaceBtwItems),
                            JBGridLayoutProducts(
                                mainAxisExtent: 320,
                                itemCount: products.length,
                                itemBuilder: (_, index) => JBVProductCard(
                                      product: products[index],
                                    )),
                          ],
                        );
                      }),
                  const SizedBox(height: JBSizes.spaceBtwItems)
                ],
              )),
        ]);
  }
}
