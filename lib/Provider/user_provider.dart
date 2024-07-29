import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  String _name = '';
  String _email = '';
  String _imageUrl = '';

  User? get user => _user;
  String get name => _name;
  String get email => _email;
  String get imageUrl => _imageUrl;

  Future<void> loadUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_user!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        _name = userData['userName'] ?? '';
        _email = userData['email'] ?? '';
        _imageUrl = userData['imageUrl'] ?? '';
      }
      notifyListeners();
    }
    print(_email);
  }

  Future<void> updateProfile({String? name, String? password, String? imageUrl}) async {
    if (_user == null) return;

    if (name != null && name.isNotEmpty) {
      _name = name;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_user!.uid)
          .update({'userName': name});
    }

    if (password != null && password.isNotEmpty) {
      await _user!.updatePassword(password);
    }

    if (imageUrl != null) {
      _imageUrl = imageUrl;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_user!.uid)
          .update({'imageUrl': imageUrl});
    }

    notifyListeners();
  }
}