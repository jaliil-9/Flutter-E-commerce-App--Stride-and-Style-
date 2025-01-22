import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/controllers/favourite_controller.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/grid_layout_products.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/vproduct_card.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../utils/constants/sizes.dart';

class FavouritePageScreen extends StatelessWidget {
  const FavouritePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;

    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: const JBAppBar(
        title: "Favourite",
        addNewIcon: true,
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(JBSizes.defaultSpace),
        child: Column(
          children: [
            Obx(
              () => FutureBuilder(
                  future: controller.favouriteProducts(),
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

                    final products = snapshot.data!;

                    return JBGridLayoutProducts(
                        mainAxisExtent: 320,
                        itemCount: products.length,
                        itemBuilder: (_, index) => JBVProductCard(
                              product: products[index],
                            ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
