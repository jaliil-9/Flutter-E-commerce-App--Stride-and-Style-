import 'package:flutter/material.dart';
import 'package:stride_style_ecom/features/shop/controllers/product/product_controller.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/brand.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../../../utils/constants/enums.dart';

class JBProductMetaData extends StatelessWidget {
  const JBProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price
              Row(
                children: [
                  if (salePercentage != null)
                    // Product Sale Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: JBStyles.burnishedGold,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '$salePercentage%',
                        style: JBStyles.secondaryLight.copyWith(
                          color: JBStyles.cream,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // Product Price
                  const SizedBox(width: JBSizes.spaceBtwItems),
                  if (product.productType ==
                          ProductType.single.toString().split('.').last &&
                      product.salePrice > 0)
                    Text('\$${product.price.toInt()}',
                        style: JBStyles.bodyLight
                            .apply(decoration: TextDecoration.lineThrough)),
                  if (product.productType ==
                          ProductType.single.toString().split('.').last &&
                      product.salePrice > 0)
                    const SizedBox(
                      width: JBSizes.spaceBtwItems,
                    ),
                  Text(
                    '\$${controller.getProductPrice(product)}',
                    style: JBStyles.priceLight,
                  )
                ],
              ),
              const SizedBox(height: JBSizes.spaceBtwItems),

              // Title
              Text(product.title, style: JBStyles.productTitleLight),
              const SizedBox(
                height: JBSizes.spaceBtwItems / 1.5,
              ),

              // Status
              Row(
                children: [
                  Text('Status', style: JBStyles.productTitleLight),
                  const SizedBox(
                    width: JBSizes.spaceBtwItems,
                  ),
                  Text(
                    controller.getProductStockStatus(product.stock),
                    style: JBStyles.priceLight,
                  ),
                ],
              ),
              const SizedBox(
                height: JBSizes.spaceBtwItems,
              ),

              // Brand
              Row(
                children: [
                  JBBrand(
                    brand: product.brand!.name,
                    showBorder: false,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
