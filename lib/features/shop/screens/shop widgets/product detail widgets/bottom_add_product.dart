import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/cart_controller.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBBottomAddProduct extends StatelessWidget {
  const JBBottomAddProduct({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    cartController.updateAlreadyAddedProductCount(product);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: JBSizes.defaultSpace, vertical: JBSizes.defaultSpace / 2),
      decoration: const BoxDecoration(
          color: JBStyles.whiteCream,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: JBStyles.coolGray),
                  child: IconButton(
                    onPressed: () =>
                        cartController.productQuantityInCart.value < 1
                            ? null
                            : cartController.productQuantityInCart.value -= 1,
                    icon: const Icon(
                      Icons.remove,
                    ),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: JBSizes.spaceBtwItems,
                ),
                Text(cartController.productQuantityInCart.value.toString(),
                    style: JBStyles.priceLight),
                const SizedBox(
                  width: JBSizes.spaceBtwItems,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: JBStyles.deepNavy),
                  child: IconButton(
                    onPressed: () =>
                        cartController.productQuantityInCart.value += 1,
                    icon: const Icon(
                      Icons.add,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: cartController.productQuantityInCart < 1
                    ? null
                    : () => cartController.addToCart(product),
                style: JBStyles.primaryButtonStyle(context),
                child: const Text('Add to Cart'))
          ],
        ),
      ),
    );
  }
}
