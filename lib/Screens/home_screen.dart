import 'package:ai_chatbot/Components/home_screen_card.dart';
import 'package:ai_chatbot/Screens/about_us.dart';
import 'package:ai_chatbot/Screens/gemini_screen.dart';
import 'package:ai_chatbot/Screens/login_screen.dart';
import 'package:ai_chatbot/Screens/profile_screen.dart';
import 'package:ai_chatbot/Screens/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text(
          'AJUTOR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeScreenCard(
                      cardName: 'ChatGPT',
                      logoPath: Image.asset('assets/images/chatgpt-logo.png', height: 80,),
                      onTap: () {},
                    ),
                    HomeScreenCard(
                      cardName: 'Gemini',
                      logoPath: Image.asset('assets/images/gemini-logo.png', height: 80,),
                      onTap: () {
                        Navigator.pushNamed(context, GeminiScreen.id);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeScreenCard(
                      cardName: 'Profile',
                      logoPath: const Icon(Icons.person, size: 80,),
                      onTap: () {
                        Navigator.pushNamed(context, ProfileScreen.id);
                      },
                    ),
                    HomeScreenCard(
                      cardName: 'Setting',
                      logoPath: const Icon(Icons.settings,size: 80,),
                      onTap: () {
                        Navigator.pushNamed(context, SettingScreen.id);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeScreenCard(
                      cardName: 'About Us',
                      logoPath: const Icon(Icons.question_mark_rounded, size: 80,),
                      onTap: () {
                        Navigator.pushNamed(context, AboutUs.id);
                      },
                    ),
                    HomeScreenCard(
                      cardName: 'Logout',
                      logoPath: const Icon(Icons.logout, size: 80,),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


