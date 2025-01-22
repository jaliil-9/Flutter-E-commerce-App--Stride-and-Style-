import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  // Empty Helper Function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  // Convert model to json structure to store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "parentId": parentId,
      "isFeatured": isFeatured,
    };
  }

  // Map json document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map json record to the user model
      return CategoryModel(
          id: document.id,
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          isFeatured: data['isFeatured'] ?? false,
          parentId: data['parentId'] ?? '');
    } else {
      return CategoryModel.empty();
    }
  }
}
