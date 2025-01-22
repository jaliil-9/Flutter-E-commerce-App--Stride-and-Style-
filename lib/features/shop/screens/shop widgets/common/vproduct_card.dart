import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/cart_controller.dart';
import 'package:stride_style_ecom/features/shop/controllers/product/product_controller.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/features/shop/screens/product_detail_screen.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/brand.dart';
import 'package:stride_style_ecom/utils/constants/enums.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

import 'product_tags.dart';

class JBVProductCard extends StatelessWidget {
  const JBVProductCard({super.key, required this.product});

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
          width: 180,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Container(
                  width: 180,
                  height: 180,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: JBStyles.whiteCream,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Stack(
                    children: [
                      // Thumbnail Image
                      Center(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            child:
                                Image(image: NetworkImage(product.thumbnail))),
                      ),

                      // Product Tags
                      ProductTags(
                        productId: product.id,
                        discount: discountPercentage != null
                            ? '$discountPercentage%'
                            : null,
                      ),
                    ],
                  )),

              // Product Details
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Text(
                      product.title,
                      style: JBStyles.priceLight,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: JBSizes.spaceBtwItems / 2),

                    // Brand
                    JBBrand(
                      brand: product.brand!.name,
                      showBorder: false,
                    ),
                  ],
                ),
              ),
              // Spacer
              const Spacer(),

              // Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        if (product.productType ==
                                ProductType.single.toString().split('.').last &&
                            product.salePrice > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '\$${product.price.toInt().toString()}',
                              style: JBStyles.bodyLight.apply(
                                  decoration: TextDecoration.lineThrough),
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
                  JBAddToCart(product: product),
                ],
              )
            ],
          )),
    );
  }
}

class JBAddToCart extends StatelessWidget {
  const JBAddToCart({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Material(
      color: Colors.transparent,
      child: GestureDetector(onTap: () {
        if (product.productType ==
            ProductType.single.toString().split('.').last) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailsScreen(product: product));
        }
      }, child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: productQuantityInCart > 0
                ? JBStyles.deepNavy.withOpacity(0.9)
                : JBStyles.cognacBrown.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: productQuantityInCart > 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    productQuantityInCart.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              : const Icon(
                  Icons.add_shopping_cart,
                  size: 20,
                  color: JBStyles.deepNavy,
                ),
        );
      })),
    );
  }
}
