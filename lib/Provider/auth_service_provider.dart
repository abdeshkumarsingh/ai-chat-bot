import 'package:ai_chatbot/Model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthServiceProvider with ChangeNotifier{

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool _isSamePassword = true;
  bool _isErrorMessage = false;
  String? _username;
  late String _signInErrorMessage;
  late String _signUpErrorMessage;
  late String _resetPasswordMessage;

  bool get isErrorMessage => _isErrorMessage;
  String get signInErrorMessage => _signInErrorMessage;
  String get signUpErrorMessage => _signUpErrorMessage;
  String get resetPasswordMessage => _resetPasswordMessage;

  bool get isSamePassword => _isSamePassword;

  void setIsSamePassword(String fpassword, String spassword) {
    if(fpassword == spassword){
      _isSamePassword = true;
    } else {
      _isSamePassword = false;
    }
    notifyListeners();
  }

  Future<User?> signUpWithEmail(String userEmail, String userName, String password) async {
    try {
      _isErrorMessage = false;
      // Attempt to create a user with email and password
      if(userEmail != '' && userName != '' && password != ''){
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: userEmail,
          password: password,
        );

        // Check if userCredential is not null and contains a valid user
        if (userCredential.user != null) {
          await _firestore.collection('Users').doc(userCredential.user?.uid).set({
            'email': userEmail,
            'userName': userName,
            'timestamp': FieldValue.serverTimestamp(),
          });

          // Notify listeners
          notifyListeners();

          // Return the user object
          return userCredential.user;
        } else {
          _isErrorMessage = true;
          _signUpErrorMessage = 'User value is null';
          return null;
        }
      } else {
        _isErrorMessage = true;
        _signUpErrorMessage = 'Textfields can\'t be blank';
      }
    } on FirebaseException catch (e) {
      // set error message to variable
      _isErrorMessage = true;
      _signUpErrorMessage = e.message.toString();
      notifyListeners();
      return null;
    }
  }

  Future<User?> signInwithEmail(String userEmail, String password) async{
    try{
      _isErrorMessage = false;
      if(userEmail != '' && password != ''){
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: userEmail, password: password);
        if(userCredential != null){
          notifyListeners();
          return userCredential.user;
        } else {
          _isErrorMessage = true;
          _signInErrorMessage = 'User value is null';
        }
      } else {
        _isErrorMessage = true;
        _signInErrorMessage = 'Textfields can\'t be blank';
      }

    } on FirebaseException catch(e){
      _isErrorMessage = true;
      _signInErrorMessage = e.message.toString();
      notifyListeners();
      return null;
    }

  }

  Future<void> resetPassword(String email) async {
    try {
      _isErrorMessage = false;
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
        _resetPasswordMessage = 'Password reset email sent. Please check your inbox.';
      } else {
        _isErrorMessage = true;
        _resetPasswordMessage = 'Email field can\'t be blank';
      }
    } on FirebaseAuthException catch (e) {
      _isErrorMessage = true;
      switch (e.code) {
        case 'invalid-email':
          _resetPasswordMessage = 'The email address is not valid.';
          break;
        case 'user-not-found':
          _resetPasswordMessage = 'No user found with this email.';
          break;
        default:
          _resetPasswordMessage = 'An unexpected error occurred. Please try again later.';
      }
    }
  }

  Future<UserModel> getUserModel() async{
    var snap = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    UserModel user = UserModel.fromJson(snap.data() as Map<String, dynamic>);
    _username = user.userName;
    return user;
  }

}