import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethodModel {
  String id;
  String cardHolderName;
  String cardNumber;
  String expiryDate;
  String securityCode;
  bool selectedPaymentMethod;

  PaymentMethodModel(
      {required this.id,
      required this.cardHolderName,
      required this.cardNumber,
      required this.expiryDate,
      this.securityCode = '***',
      this.selectedPaymentMethod = false});

  static PaymentMethodModel empty() => PaymentMethodModel(
      id: '', cardHolderName: '', cardNumber: '', expiryDate: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'securityCode': securityCode,
      'selectedPaymentMethod': selectedPaymentMethod
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> data) {
    try {
      return PaymentMethodModel(
        id: data['id'] ?? '',
        cardHolderName: data['cardHolderName'] ?? '',
        cardNumber: data['cardNumber'] ?? '',
        expiryDate: data['expiryDate'] ?? '',
        securityCode: data['securityCode'] ?? '',
        selectedPaymentMethod: data['selectedPaymentMethod'] ?? false,
      );
    } catch (e) {
      rethrow;
    }
  }

  factory PaymentMethodModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return PaymentMethodModel(
      id: snapshot.id,
      cardHolderName: data['cardHolderName'] ?? '',
      cardNumber: data['cardNumber'] ?? '',
      expiryDate: data['expiryDate'] ?? '',
      securityCode: data['securityCode'] ?? '',
      selectedPaymentMethod: data['selectedPaymentMethod'] ?? false,
    );
  }
}
