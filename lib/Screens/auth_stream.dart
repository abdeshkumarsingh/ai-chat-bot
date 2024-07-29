import 'package:ai_chatbot/Screens/home_screen.dart';
import 'package:ai_chatbot/Screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  static String id = 'authStream';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('Something went wrong');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        } else {
          if(snapshot.hasData){
            return HomeScreen();
          } else {
            return SignupScreen();
          }
        }
      },
    ),
    );
  }
}
