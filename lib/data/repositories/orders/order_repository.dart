import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) throw "Unable to find information, try again later";

      // Add debug print statements
      print('Fetching orders for user: $userId');

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();

      print('Query result: ${result.docs.length} documents found');

      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      print('Error fetching orders: $e');
      throw "Something went wrong while fetching orders data, try again later";
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      final orderData = order.toJson();

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(orderData);
    } catch (e) {
      throw 'Something went wrong while saving order information: $e';
    }
  }
}
