import 'dart:convert';

import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/product/product_repository.dart';
import 'package:stride_style_ecom/features/shop/models/product_model.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';
import 'package:stride_style_ecom/utils/local_storage/storage.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  // Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourite();
  }

  // Initialize Favourite by reading from local storage
  void initFavourite() async {
    final json = JBLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  // Add product to favorites
  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavouriteToStorage();
      JBLoaders.customToast(message: "Added to Favourites!");
    } else {
      JBLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavouriteToStorage();
      favorites.refresh();
      JBLoaders.customToast(message: "Removed from Favourites!");
    }
  }

  void saveFavouriteToStorage() {
    final encodedFavourites = json.encode(favorites);
    JBLocalStorage.instance().saveData('favorites', encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favorites.keys.toList());
  }
}
