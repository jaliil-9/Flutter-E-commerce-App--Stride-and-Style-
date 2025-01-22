import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/models/brand_model.dart';
import 'package:stride_style_ecom/features/shop/models/category_model.dart';
import 'package:stride_style_ecom/utils/exceptions/firebase_exceptions.dart';
import 'package:stride_style_ecom/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Fetch all categories
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Fetch sub-categories
  Future<List<BrandModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("Brands")
          .where('categoryId', isEqualTo: categoryId.toLowerCase())
          .get();
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnap(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
