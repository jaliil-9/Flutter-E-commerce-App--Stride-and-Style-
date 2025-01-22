import 'package:flutter/material.dart';
import 'package:stride_style_ecom/features/shop/models/cart_item_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/store%20widgets/brand.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBCartItem extends StatelessWidget {
  const JBCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: JBStyles.whiteCream,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Image(image: NetworkImage(cartItem.image ?? '')),
        ),
        const SizedBox(
          width: JBSizes.spaceBtwItems,
        ),

        /// Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand
              JBBrand(
                brand: cartItem.brandName ?? '',
                showBorder: false,
              ),

              // Product Title
              Flexible(
                child: Text(
                  cartItem.title,
                  style: JBStyles.productTitleLight,
                  maxLines: 2,
                ),
              ),

              // Attributes
              Text.rich(TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map((e) => TextSpan(children: [
                            TextSpan(
                                text: ' ${e.key} ', style: JBStyles.bodyLight),
                            TextSpan(
                                text: '${e.value} ', style: JBStyles.priceLight)
                          ]))
                      .toList()))
            ],
          ),
        )
      ],
    );
  }
}
