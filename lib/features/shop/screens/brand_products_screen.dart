import 'package:flutter/material.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/controllers/brand_controller.dart';
import 'package:stride_style_ecom/features/shop/models/brand_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/brand.dart';
import 'package:stride_style_ecom/features/shop/screens/view%20all%20screens/view_all_screen.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
        backgroundColor: JBStyles.cream,
        appBar: JBAppBar(
          title: brand.name,
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(JBSizes.defaultSpace),
            child: Column(
              children: [
                JBBrand(
                  brand: brand.name,
                  showBorder: true,
                ),
                const SizedBox(
                  height: JBSizes.spaceBtwSections,
                ),
                FutureBuilder(
                    future: controller.getBrandProducts(brandName: brand.name),
                    builder: (context, snapshot) {
                      // Check the state of future builder snapshot
                      const loader = CircularProgressIndicator(
                        color: JBStyles.burnishedGold,
                      );
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: loader);
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

                      final brandProducts = snapshot.data!;
                      return JBSortableProducts(products: brandProducts);
                    })
              ],
            ),
          ),
        ));
  }
}
