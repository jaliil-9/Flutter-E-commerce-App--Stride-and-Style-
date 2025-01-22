import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/product/variation_controller.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/product%20detail%20widgets/choice_chip.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class JBProductAttributes extends StatelessWidget {
  const JBProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Selected Variation Price & Description
          if (controller.selectedVariation.value.id.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: JBStyles.coolGray.withOpacity(0.7)),
              child: Column(
                children: [
                  // Title, Price, & Stock Status
                  Row(
                    children: [
                      Text('Variation',
                          style: JBStyles.priceLight
                              .apply(color: JBStyles.whiteCream)),
                      const SizedBox(
                        width: JBSizes.spaceBtwItems,
                      ),

                      /// Price & Status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price
                          Row(
                            children: [
                              Text(
                                'Price:  ',
                                style: JBStyles.bodyLight
                                    .apply(color: JBStyles.whiteCream),
                              ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                    '\$${controller.selectedVariation.value.price.toInt()}',
                                    style: JBStyles.bodyLight.apply(
                                        color: JBStyles.whiteCream,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              const SizedBox(width: JBSizes.spaceBtwItems / 2),
                              Text(
                                '\$${controller.getVariationPrice()}',
                                style: JBStyles.priceLight
                                    .apply(color: JBStyles.whiteCream),
                              )
                            ],
                          ),

                          // Status
                          Row(
                            children: [
                              Text(
                                'Status:  ',
                                style: JBStyles.bodyLight
                                    .apply(color: JBStyles.whiteCream),
                              ),
                              Text(controller.variationStockStatus.value,
                                  style: JBStyles.priceLight
                                      .apply(color: JBStyles.whiteCream))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),

                  // Variation Description
                  Text(
                    controller.selectedVariation.value.description,
                    style: JBStyles.bodyLight.apply(color: JBStyles.whiteCream),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),

          const SizedBox(height: JBSizes.spaceBtwItems),

          /// Variations
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: product.productAttributes!
                  .map(
                    (attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JBSectionHeading(
                          headingText: attribute.name ?? '',
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: JBSizes.spaceBtwItems / 2,
                        ),
                        Obx(
                          () => Wrap(
                              spacing: JBSizes.spaceBtwItems / 2,
                              children: attribute.values!.map((attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    attributeValue;
                                final isAvailable = controller
                                    .getAllAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(attributeValue);
                                return JBChoiceChip(
                                    selected: isSelected,
                                    text: attributeValue,
                                    onSelected: isAvailable
                                        ? (selected) {
                                            if (selected && isAvailable) {
                                              controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  attributeValue);
                                            }
                                          }
                                        : null);
                              }).toList()),
                        ),
                      ],
                    ),
                  )
                  .toList()),

          const SizedBox(
            height: JBSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
