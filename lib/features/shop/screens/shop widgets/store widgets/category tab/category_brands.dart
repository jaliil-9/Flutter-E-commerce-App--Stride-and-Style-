import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/brand_controller.dart';
import 'package:stride_style_ecom/features/shop/models/category_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/brand_overview_card.dart';

import '../../../../../../utils/constants/style.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return FutureBuilder(
        future: controller.getBrandForCategory(
          category.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator(color: JBStyles.burnishedGold));
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available!', style: JBStyles.priceLight),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong!', style: JBStyles.priceLight),
            );
          }
          final brands = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
                final brand = brands[index];

                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandName: brand.name, limit: 3),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: JBStyles.burnishedGold,
                        ));
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

                      return JBBrandOverviewCard(
                          brand: brand,
                          images: products.map((e) => e.thumbnail).toList());
                    });
              });
        });
  }
}
