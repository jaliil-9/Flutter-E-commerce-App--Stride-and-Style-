import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/shop/models/banner_model.dart';
import 'package:stride_style_ecom/utils/exceptions/firebase_exceptions.dart';
import 'package:stride_style_ecom/utils/exceptions/format_exceptions.dart';
import 'package:stride_style_ecom/utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all order related to current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
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

  // Upload banners to Firebase
}
