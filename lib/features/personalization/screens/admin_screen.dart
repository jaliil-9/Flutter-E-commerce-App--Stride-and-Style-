import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../utils/helpers/product_seeder.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JBStyles.cream,
      appBar: const JBAppBar(
        title: 'Admin Panel',
        showBackArrow: true,
      ),
      body: Center(
        child: ElevatedButton(
          style: JBStyles.primaryButtonStyle(context),
          onPressed: () async {
            try {
              final seeder = Get.put(ProductSeeder());
              // Show loading indicator
              Get.dialog(const Center(child: CircularProgressIndicator()));
              // Seed with default number of products
              await seeder.seedProducts();
              // Or specify custom number:
              // await seeder.seedProducts(productsPerBrand: 5);
              Get.back(); // Remove loading indicator
              Get.snackbar('Success', 'Products seeded successfully');
            } catch (e) {
              Get.back(); // Remove loading indicator
              Get.snackbar('Error', 'Failed to seed products: $e');
            }
          },
          child: Text('Seed Products', style: JBStyles.buttonLight),
        ),
      ),
    );
  }
}
