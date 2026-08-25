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

  factory AddressModel.fromMap(
      Map<String, dynamic> map, {
        String id = '',
      }) {
    return AddressModel(
      id: id,
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      postalCode: map['postalCode'] ?? '',
      country: map['country'] ?? '',
      selectedAddress: map['selectedAddress'] ?? true,
      dateTime: map['dateTime'] is Timestamp
          ? (map['dateTime'] as Timestamp).toDate()
          : map['dateTime'] is DateTime
          ? map['dateTime'] as DateTime
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': dateTime,
      'selectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    if (document.data() == null || document.data()!.isEmpty) {
      return AddressModel.empty();
    }

    final data = document.data()!;

    return AddressModel(
      id: document.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      selectedAddress: data['selectedAddress'] ?? true,
      dateTime: data['dateTime'] != null
          ? (data['dateTime'] as Timestamp).toDate()
          : null,
    );
  }

  factory AddressModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document,
      ) {
    final data = document.data()! as Map<String, dynamic>;

    return AddressModel(
      id: document.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      selectedAddress: data['selectedAddress'] ?? true,
      dateTime: data['dateTime'] != null
          ? (data['dateTime'] as Timestamp).toDate()
          : null,
    );
  }

  factory AddressModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    final data = document.data();

    if (data == null || data.isEmpty) {
      return AddressModel.empty();
    }

    return AddressModel(
      id: document.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      selectedAddress: data['selectedAddress'] ?? true,
      dateTime: data['dateTime'] is Timestamp
          ? (data['dateTime'] as Timestamp).toDate()
          : null,
    );
  }

  @override
  String toString() {
  return '$street, $city, $state, $postalCode, $country';
  }
}
