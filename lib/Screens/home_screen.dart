import 'package:ai_chatbot/Components/home_screen_card.dart';
import 'package:ai_chatbot/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('AJUTOR', style: TextStyle(fontWeight: FontWeight.bold),), leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 HomeScreenCard(cardName: 'ChatGPT', logoPath: 'assets/images/chatgpt-logo.png', onTap: (){print('button 1 clicked');}),
                HomeScreenCard(cardName: 'Gemini', logoPath: 'assets/images/gemini-logo.png', onTap: (){print('button 2 clicked');}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeScreenCard(cardName: 'Community', logoPath: 'assets/images/group.png', onTap: (){}),
                HomeScreenCard(cardName: 'Profile', logoPath: 'assets/images/profile.png', onTap: (){}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeScreenCard(cardName: 'About Us', logoPath: 'assets/images/about.png', onTap: (){}),
                HomeScreenCard(cardName: 'Logout', logoPath: 'assets/images/logout.png', onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen(),));
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}


