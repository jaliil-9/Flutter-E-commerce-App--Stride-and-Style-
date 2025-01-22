import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/controllers/cart_controller.dart';
import 'package:stride_style_ecom/features/shop/controllers/product/images_controller.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  // Select attribute and variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    // Attribute selected gets added to selectedAttributes
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
        (variation) => _isSameAttributeValues(
            variation.attributeValues, selectedAttributes),
        orElse: () => ProductVariationModel.empty());

    // Show selected variation image as main image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // Update selected variation
    this.selectedVariation.value = selectedVariation;

    // Update selected variation product status
    getProductVariationStockStatus();
  }

  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    // If selected attribute contains 3 variations and the current variation contains 2 thn return
    if (variationAttributes.length != selectedAttributes.length) return false;

    // If any attribute is different then return
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  // Check product variation availability
  Set<String?> getAllAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    // Pass variations to check available attributes
    final availableVariationAttributeValues = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toInt()
        .toString();
  }

  // Check product variation stock status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  // Reset selected attributes when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
