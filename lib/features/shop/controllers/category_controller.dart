import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/categories/category_repository.dart';
import 'package:stride_style_ecom/data/repositories/product/product_repository.dart';
import 'package:stride_style_ecom/features/shop/models/brand_model.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';

import '../models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepo = Get.put(CategoryRepository());
  final allCategories = <CategoryModel>[].obs;
  final featuredCategories = <CategoryModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader
      isLoading.value = true;

      // Fetch categories from source
      final categories = await _categoryRepo.fetchAllCategories();

      // Update categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories.where(
          (category) => category.isFeatured && category.parentId.isEmpty));
    } catch (e) {
      JBLoaders.errorSnackBar(title: "Oops..", message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  // Load sub category data
  Future<List<BrandModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _categoryRepo.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
      return [];
    }
  }

  // Get category or sub-category products
  Future<List<ProductModel>> getBrandProducts(
      {required String brandName, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandName: brandName, limit: limit);
      return products;
    } catch (e) {
      JBLoaders.errorSnackBar(title: "Oops..", message: e.toString());
      return [];
    }
  }

  // Get category or sub-category products
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      JBLoaders.errorSnackBar(title: "Oops..", message: e.toString());
      return [];
    }
  }
}
