import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/grid_layout_products.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/vproduct_card.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/all_products_controller.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
        backgroundColor: JBStyles.cream,

        // AppBar
        appBar: JBAppBar(
          title: title,
          showBackArrow: true,
        ),

        // Body
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(JBSizes.defaultSpace),
                child: FutureBuilder(
                    future:
                        futureMethod ?? controller.fetchProductsByQuery(query),
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

                      final products = snapshot.data!;
                      controller.asignProducts(products);

                      return JBSortableProducts(products: products);
                    }))));
  }
}

class JBSortableProducts extends StatelessWidget {
  const JBSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Column(children: [
      // Dropdown
      DropdownButtonFormField(
        value: controller.selectedSortOption.value,
        decoration: JBStyles.inputDecoration(context,
            prefixIcon: const Icon(Icons.sort)),
        onChanged: (value) {
          controller.sortProducts(value!);
        },
        items: [
          "Name",
          "Price: Low to High",
          "Price: High to Low",
          "Newest",
          "Sale"
        ]
            .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
      ),
      const SizedBox(height: JBSizes.spaceBtwSections),

      // Products
      Obx(
        () => JBGridLayoutProducts(
            mainAxisExtent: 320,
            itemCount: controller.products.length,
            itemBuilder: (_, index) => JBVProductCard(
                  product: controller.products[index],
                )),
      )
    ]);
  }
}
