import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/models/brand_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnap(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JBFormatException();
    } on PlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // Get brands for categories
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      // Directly query brands where categoryId matches
      final brandsQuery = await _db
          .collection('Brands')
          .where('categoryId', isEqualTo: categoryId)
          .limit(2)
          .get();

      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnap(doc)).toList();
      return brands;
    } on FirebaseException catch (e) {
      throw JBFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JBFormatException();
    } on PlatformException catch (e) {
      throw JBPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
