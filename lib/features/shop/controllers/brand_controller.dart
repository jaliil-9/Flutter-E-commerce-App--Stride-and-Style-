import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/product/product_repository.dart';
import 'package:stride_style_ecom/features/shop/models/brand_model.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';

import '../../../data/repositories/brands/brand_repository.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepo = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // Load brands
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader
      isLoading.value = true;

      // Get brands
      final brands = await brandRepo.getAllBrands();

      // Assign brands
      allBrands.assignAll(brands);

      // Get featured brands
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      JBLoaders.errorSnackBar(title: "Oopse..", message: e.toString());
    } finally {
      // Hide loader
      isLoading.value = false;
    }
  }

  // Get brands for category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands = await brandRepo.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
      return [];
    }
  }

  // Get brand specific products
  Future<List<ProductModel>> getBrandProducts(
      {required String brandName, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandName: brandName, limit: limit);
      return products;
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
      return [];
    }
  }
}
