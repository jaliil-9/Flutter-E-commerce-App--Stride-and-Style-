import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/product_tags.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/brand.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import '../../../../../utils/constants/enums.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';
import '../../product_detail_screen.dart';

class JBHProductCard extends StatelessWidget {
  const JBHProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final discountPercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final productPrice = controller.getProductPrice(product);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
          width: 310,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: JBStyles.coolGray,
                  offset: Offset(0.0, 0.5),
                  blurRadius: 0,
                  spreadRadius: 0),
            ],
          ),
          child: Row(
            children: [
              /// Thumbnail
              Container(
                  height: 120,
                  width: 120,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: JBStyles.whiteCream,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Stack(
                    children: [
                      /// Thumbnail Image
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            child:
                                Image(image: NetworkImage(product.thumbnail))),
                      ),

                      /// Product Tag
                      ProductTags(
                        showFav: false,
                        productId: product.id,
                        discount: discountPercentage != null
                            ? '$discountPercentage%'
                            : null,
                      ),
                    ],
                  )),

              /// Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Title
                          Text(product.title,
                              style: JBStyles.priceLight, maxLines: 2),
                          const SizedBox(
                            height: JBSizes.spaceBtwItems / 2,
                          ),

                          // Product Brand
                          JBBrand(
                            brand: product.brand!.name,
                            showBorder: false,
                          ),
                        ],
                      ),

                      // Spacer
                      const Spacer(),

                      Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      // Product Price
                                      if (product.productType ==
                                              ProductType.single
                                                  .toString()
                                                  .split('.')
                                                  .last &&
                                          product.salePrice > 0)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            '\$${product.price.toInt().toString()}',
                                            style: JBStyles.bodyLight.apply(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ),

                                      // Price
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          '\$$productPrice',
                                          style: JBStyles.priceLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Add to Cart Button
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: JBStyles.cognacBrown.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add_shopping_cart,
                                  size: 20,
                                  color: JBStyles.deepNavy,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
