import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;
  String categoryId;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
    required this.categoryId,
  });

  // Empty helper function
  static BrandModel empty() =>
      BrandModel(id: '', name: '', image: '', categoryId: '');

  // Convert model to json format
  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'productsCount': productsCount,
      'isFeatured': isFeatured,
    };
  }

  // Map json file to model
  factory BrandModel.fromSnapshot(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        categoryId: data['categoryId'] ?? '');
  }

  factory BrandModel.fromSnap(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map Json record to the model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        categoryId: data['categoryId'] ?? '',
        productsCount: data['ProductCount'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
