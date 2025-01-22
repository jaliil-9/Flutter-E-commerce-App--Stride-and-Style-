import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/product/product_repository.dart';
import '../../data/supabase_config.dart';
import '../../features/shop/models/brand_model.dart';
import '../../features/shop/models/product_attribute_model.dart';
import '../../features/shop/models/product_model.dart';
import '../../features/shop/models/product_variation_model.dart';

class ProductSeederConfig {
  // Price ranges
  static const Map<String, Map<String, double>> priceRanges = {
    'sneakers': {'min': 89.99, 'max': 199.99},
    'boots': {'min': 129.99, 'max': 299.99},
    'regular': {'min': 59.99, 'max': 149.99},
    'classic': {'min': 149.99, 'max': 399.99},
  };

  // Available sizes per category
  static const Map<String, List<String>> sizes = {
    'sneakers': ['7', '7.5', '8', '8.5', '9', '9.5', '10', '10.5', '11'],
    'boots': ['7', '8', '9', '10', '11', '12'],
    'regular': ['6', '7', '8', '9', '10', '11'],
    'classic': ['7', '8', '9', '10', '11', '12'],
  };

  // Available colors per category
  static const Map<String, List<String>> colors = {
    'sneakers': ['White', 'Black', 'Grey', 'Green'],
    'boots': ['Black', 'Brown', 'Tan', 'Grey'],
    'regular': ['White', 'Black', 'Navy', 'Grey'],
    'classic': ['Black', 'Brown', 'Burgundy', 'Tan'],
  };

  // Number of products per brand
  static const int productsPerBrand = 3;

  // Chance of product having a sale price (0.0 to 1.0)
  static const double saleChance = 0.3;

  // Sale discount percentage range
  static const double minDiscount = 0.1; // 10%
  static const double maxDiscount = 0.4; // 40%

  // Stock range
  static const int minStock = 10;
  static const int maxStock = 100;
}

class ProductSeeder {
  static ProductSeeder get instance => Get.find();
  final _productRepo = Get.put(ProductRepository());
  final _supabaseConfig = SupabaseConfig.instance;

  // Brand data structure
  final Map<String, List<String>> categoryBrands = {
    'sneakers': ['Nike', 'Adidas', 'New Balance', 'Puma'],
    'boots': ['Timberland', 'Dr. Martens', 'Chelsea', 'UGG'],
    'regular': ['Vans', 'Converse', 'Reebok', 'Skechers'],
    'classic': ['Allen Edmonds', 'Johnston & Murphy', 'Clarks', 'Cole Haan']
  };

  // Helper to generate SKU
  String _generateSKU(String category, String brand, int productNumber) {
    return '${category.substring(0, 3).toUpperCase()}'
        '${brand.replaceAll(' ', '').substring(0, 3).toUpperCase()}'
        '${productNumber.toString().padLeft(4, '0')}';
  }

  // Upload image to Supabase
  Future<String> _uploadProductImage(
      Uint8List imageBytes, String fileName) async {
    try {
      await _supabaseConfig.client.storage.from('product-images').uploadBinary(
            fileName,
            imageBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      return _supabaseConfig.client.storage
          .from('product-images')
          .getPublicUrl(fileName);
    } catch (e) {
      if (e is StorageException) {
        throw "Storage error: ${e.message}";
      }
      throw "Failed to upload image: $e";
    }
  }

  Future<Map<String, dynamic>> _processProductImages(
      String category, String brand, String productFolder) async {
    try {
      final baseDir = 'assets/products_images/$category/$brand/$productFolder';
      final thumbnailPath = '$baseDir/thumbnail.jpg';

      // First verify if the asset exists by trying to load it
      try {
        await rootBundle.load(thumbnailPath);
      } catch (e) {
        throw "Product assets don't exist: $thumbnailPath";
      }

      // Upload thumbnail
      final thumbnailBytes = await rootBundle.load(thumbnailPath);
      final thumbnailUrl = await _uploadProductImage(
        thumbnailBytes.buffer.asUint8List(),
        'products/$category/$brand/$productFolder/thumbnail.jpg',
      );

      // For additional images, we need to use the manifest
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifest = json.decode(manifestContent);

      List<String> imageUrls = [];
      final assetKeys = manifest.keys.where((String key) =>
          key.startsWith(baseDir) &&
          key.endsWith('.jpg') &&
          !key.endsWith('thumbnail.jpg'));

      for (final assetPath in assetKeys) {
        final bytes = await rootBundle.load(assetPath);
        final fileName = path.basename(assetPath);

        final imageUrl = await _uploadProductImage(
          bytes.buffer.asUint8List(),
          'products/$category/$brand/$productFolder/$fileName',
        );
        imageUrls.add(imageUrl);
      }

      return {
        'thumbnail': thumbnailUrl,
        'images': imageUrls,
      };
    } catch (e) {
      print('Error processing images: $e');
      rethrow;
    }
  }

  Future<List<ProductVariationModel>> _processVariations(
      String category, String brand, String productFolder) async {
    try {
      final variationsPath =
          'assets/products_images/$category/$brand/$productFolder/variations';
      List<ProductVariationModel> variations = [];
      int variantIndex = 0;

      // Load asset manifest to find all variation images
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifest = json.decode(manifestContent);

      // Filter for variation images in this product's folder
      final variationAssets = manifest.keys
          .where((String key) =>
              key.startsWith(variationsPath) && key.endsWith('.jpg'))
          .toList();

      // If no variations found, return empty list
      if (variationAssets.isEmpty) {
        return [];
      }

      // Process each variation
      for (final assetPath in variationAssets) {
        variantIndex++;
        final fileName = path.basename(assetPath);

        // Load the image bytes
        final bytes = await rootBundle.load(assetPath);

        final imageUrl = await _uploadProductImage(
          bytes.buffer.asUint8List(),
          'products/$category/$brand/$productFolder/variations/$fileName',
        );

        // Generate variation data
        variations.add(ProductVariationModel(
          id: '$productFolder-variant-$variantIndex',
          sku: '${_generateSKU(category, brand, variantIndex)}-VAR',
          image: imageUrl,
          price: _generatePrice(category),
          salePrice: _generateSalePrice(_generatePrice(category)),
          stock: Random().nextInt(50) + 10,
          attributeValues: {
            'Color': ProductSeederConfig.colors[category]![
                Random().nextInt(ProductSeederConfig.colors[category]!.length)],
            'Size': ProductSeederConfig.sizes[category]![
                Random().nextInt(ProductSeederConfig.sizes[category]!.length)],
          },
          description: 'Variant $variantIndex of the product',
        ));
      }

      return variations;
    } catch (e) {
      print('Error processing variations: $e');
      return []; // Return empty list if there's an error
    }
  }

  // Create a single product
  Future<void> _createProduct(String category, String brand,
      String productFolder, int productIndex) async {
    try {
      final images =
          await _processProductImages(category, brand, productFolder);
      final variations =
          await _processVariations(category, brand, productFolder);

      final basePrice = _generatePrice(category);
      final hasSale = Random().nextBool();
      final salePrice = hasSale ? basePrice * 0.8 : 0.0;

      final product = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        stock: Random().nextInt(100) + 20,
        sku: _generateSKU(category, brand, productIndex),
        price: basePrice,
        salePrice: salePrice,
        title:
            '$brand ${category.substring(0, 1).toUpperCase()}${category.substring(1)} Model ${productIndex + 1}',
        thumbnail: images['thumbnail'],
        productType: variations.isEmpty ? 'single' : 'variable',
        images: images['images'],
        isFeatured: Random().nextBool(),
        brand: BrandModel(
            id: brand.toLowerCase().replaceAll(' ', '_'),
            name: brand,
            image: 'brand_image_url_here',
            categoryId: ''),
        description:
            'Premium quality $brand $category featuring cutting-edge design and superior comfort.',
        categoryId: category.toLowerCase(),
        productAttributes: variations.isEmpty
            ? []
            : [
                ProductAttributeModel(
                  name: 'Color',
                  values: ProductSeederConfig.colors[category]!,
                ),
                ProductAttributeModel(
                  name: 'Size',
                  values: ProductSeederConfig.sizes[category]!,
                ),
              ],
        productVariations: variations,
      );

      await _productRepo.createProduct(product);
    } catch (e) {
      print('Error creating product: $e');
      rethrow;
    }
  }

  Future<void> seedProducts({int? productsPerBrand}) async {
    try {
      final numberOfProducts =
          productsPerBrand ?? ProductSeederConfig.productsPerBrand;

      for (var category in categoryBrands.keys) {
        for (var brand in categoryBrands[category]!) {
          for (int i = 0; i < numberOfProducts; i++) {
            await _createProduct(category, brand, 'product${i + 1}', i);
          }
        }
      }
    } catch (e) {
      print('Error seeding products: $e');
      rethrow;
    }
  }

  double _generatePrice(String category) {
    final range = ProductSeederConfig.priceRanges[category]!;
    return Random().nextDouble() * (range['max']! - range['min']!) +
        range['min']!;
  }

  double _generateSalePrice(double originalPrice) {
    if (Random().nextDouble() < ProductSeederConfig.saleChance) {
      final discountPercent = Random().nextDouble() *
              (ProductSeederConfig.maxDiscount -
                  ProductSeederConfig.minDiscount) +
          ProductSeederConfig.minDiscount;
      return originalPrice * (1 - discountPercent);
    }
    return 0.0;
  }
}
