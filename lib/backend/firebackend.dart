import 'package:cloud_firestore/cloud_firestore.dart';

class firebaseBackend {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> createUser(String email, Map<String, dynamic> data) async {
    await firestore.collection('users').doc(email).set(data).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return await firestore
        .collection('users')
        .where('email_address', isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
}
