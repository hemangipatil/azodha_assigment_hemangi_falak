import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository(this.firestore);

  Future<void> addContact({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    await firestore.collection('contacts').add({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    });
  }
}
