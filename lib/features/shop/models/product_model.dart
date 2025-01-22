import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stride_style_ecom/features/shop/models/brand_model.dart';
import 'package:stride_style_ecom/features/shop/models/product_attribute_model.dart';
import 'package:stride_style_ecom/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    required this.thumbnail,
    required this.productType,
    this.salePrice = 0.0,
    this.images,
    this.date,
    this.sku,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.productAttributes,
    this.productVariations,
  });

  // Empty helper function
  static ProductModel empty() => ProductModel(
        id: '',
        stock: 0,
        price: 0,
        title: '',
        thumbnail: '',
        productType: '',
      );

  // Map model to json format
  toJson() {
    return {
      'SKU': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'images': images ?? [],
      'thumbnail': thumbnail,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'brand': brand!.toJson(),
      'description': description,
      'productType': productType,
      'productAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'productVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  // Map json to model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    if (data.isEmpty) return ProductModel.empty();
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['title'] ?? '',
      stock: data['stock'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      brand: BrandModel.fromSnapshot(data['brand']),
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: (data['productAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromSnapshot(e))
          .toList(),
      productVariations: (data['productVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromSnapshot(e))
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['title'] ?? '',
      stock: data['stock'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      productType: data['productType'] ?? '',
      brand: BrandModel.fromSnapshot(data['brand']),
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes: (data['productAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromSnapshot(e))
          .toList(),
      productVariations: (data['productVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromSnapshot(e))
          .toList(),
    );
  }
}
