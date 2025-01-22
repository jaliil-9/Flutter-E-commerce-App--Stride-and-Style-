import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': dateTime ?? DateTime.now(),
      'selectedAddress': selectedAddress
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    try {
      return AddressModel(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        street: data['street'] ?? '',
        city: data['city'] ?? '',
        state: data['state'] ?? '',
        postalCode: data['postalCode'] ?? '',
        country: data['country'] ?? '',
        dateTime: data['dateTime'] != null
            ? (data['dateTime'] as Timestamp).toDate()
            : DateTime.now(),
        selectedAddress: data['selectedAddress'] as bool? ?? true,
      );
    } catch (e) {
      rethrow;
    }
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      dateTime: data['dateTime'] != null
          ? (data['dateTime'] as Timestamp).toDate()
          : DateTime.now(),
      selectedAddress: data['selectedAddress'] as bool? ?? true,
    );
  }

  static AddressModel empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: '',
      );

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
