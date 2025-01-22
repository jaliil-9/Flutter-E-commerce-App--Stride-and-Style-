import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:stride_style_ecom/features/personalization/models/address_model.dart';
import 'package:stride_style_ecom/features/shop/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel(
      {required this.id,
      this.userId = '',
      required this.status,
      required this.totalAmount,
      required this.orderDate,
      this.paymentMethod = 'Paypal',
      this.address,
      this.deliveryDate,
      required this.items});

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  String get formattedOrderDate => getFormattedDate(orderDate);
  String get formattedDelivery =>
      deliveryDate != null ? getFormattedDate(deliveryDate!) : '';
  String get orderStatusText => status;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;

      DateTime parseDate(dynamic dateField) {
        if (dateField == null) return DateTime.now(); // Default to now if null
        if (dateField is Timestamp) {
          return dateField.toDate(); // Parse Timestamp
        }
        if (dateField is String) {
          return DateTime.parse(dateField); // Parse ISO8601 string
        }
        throw 'Invalid date format: $dateField'; // Handle unexpected formats
      }

      return OrderModel(
        id: data['id'] ?? '',
        userId: data['userId'] ?? '',
        status: data['status'] ?? 'Processing',
        totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
        orderDate: parseDate(data['orderDate']),
        paymentMethod: data['paymentMethod'] ?? 'Unknown',
        address: data['address'] != null
            ? AddressModel.fromMap(Map<String, dynamic>.from(data['address']))
            : null,
        deliveryDate: data['deliveryDate'] != null
            ? parseDate(data['deliveryDate'])
            : null,
        items: data['items'] != null
            ? (data['items'] as List).map((item) {
                if (item is Map<String, dynamic>) {
                  return CartItemModel.fromJson(
                      Map<String, dynamic>.from(item));
                }
                print('Invalid item data: $item');
                return CartItemModel.empty();
              }).toList()
            : [],
      );
    } catch (e, stackTrace) {
      print('Error parsing OrderModel: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
