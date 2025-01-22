import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/authentication/authentication_repository.dart';
import 'package:stride_style_ecom/features/personalization/models/payment_method_model.dart';

class PaymentMethodRepository extends GetxController {
  static PaymentMethodRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch user payment methods from Firestore
  Future<List<PaymentMethodModel>> fetchUserPaymentMethods() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) throw "Unable to find information, try again later";

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection("Payment_Methods")
          .get();
      return result.docs
          .map((documentSnapshot) =>
              PaymentMethodModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw "Something went wrong, try again later.";
    }
  }

  // Update selected payment method status in Firestore
  Future<void> updateSelectedField(String paymentId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Payment_Methods')
          .doc(paymentId)
          .update({'selectedPaymentMethod': selected});
    } catch (e) {
      throw "Unable to update payment method selection, try again later";
    }
  }

  // Add payment method to Firestore
  Future<String> addPaymentMethod(PaymentMethodModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Payment_Methods')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong, try again later';
    }
  }
}
