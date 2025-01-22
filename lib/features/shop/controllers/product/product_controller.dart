import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/product/product_repository.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/utils/constants/enums.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // Variables
  final isLoading = false.obs;
  final featuredProducts = <ProductModel>[].obs;
  final productRepo = Get.put(ProductRepository());

  @override
  onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  // Fetch featured products
  void fetchFeaturedProducts() async {
    try {
      // Start loading
      isLoading.value = true;

      // Fetch products
      final products = await productRepo.getFeaturedProducts();

      // Assign products
      featuredProducts.assignAll(products);
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch all featured products
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // Fetch products
      final products = await productRepo.getAllFeaturedProducts();
      return products;
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
      return [];
    }
  }

  // Get product price / price range
  String getProductPrice(ProductModel product) {
    // If no variations exist, return simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      double price =
          (product.salePrice > 0 ? product.salePrice : product.price);
      return price.toInt().toString();
    } else {
      // Check if product has variations
      if (product.productVariations == null ||
          product.productVariations!.isEmpty) {
        double price =
            (product.salePrice > 0 ? product.salePrice : product.price);
        return price.toInt().toString();
      }

      double smallestPrice = double.infinity;
      double largestPrice = -double.infinity;

      // Calculate smallest and largest variations
      for (var variation in product.productVariations!) {
        // Consider sale price or regular price
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // Truncate decimal parts
      int smallestPriceInt = smallestPrice.toInt();
      int largestPriceInt = largestPrice.toInt();

      // Return the price range or single price
      if (smallestPriceInt == largestPriceInt) {
        return largestPriceInt.toString();
      } else {
        return '$smallestPriceInt - \$$largestPriceInt';
      }
    }
  }

  // Calculate discount %
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // Check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? "In Stock" : 'Out of Stock';
  }
}
