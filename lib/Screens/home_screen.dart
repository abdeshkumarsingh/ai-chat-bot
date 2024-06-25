import 'package:ai_chatbot/Components/home_screen_card.dart';
import 'package:ai_chatbot/Screens/signup_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('AJUTOR', style: TextStyle(fontWeight: FontWeight.bold),), actions: [IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));}, icon: Icon(Icons.logout))], leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 HomeScreenCard(cardName: 'Facebook', logoPath: 'assets/images/facebook.png', onTap: (){print('button 1 clicked');}),
                HomeScreenCard(cardName: 'Facebook', logoPath: 'assets/images/facebook.png', onTap: (){print('button 2 clicked');}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeScreenCard(cardName: 'Facebook', logoPath: 'assets/images/facebook.png', onTap: (){}),
                HomeScreenCard(cardName: 'Facebook', logoPath: 'assets/images/facebook.png', onTap: (){}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeScreenCard(cardName: 'Facebook', logoPath: 'assets/images/facebook.png', onTap: (){}),
                HomeScreenCard(cardName: 'Facebook', logoPath: 'assets/images/facebook.png', onTap: (){}),
              ],
            )
          ],
        ),
      ),
    );
  }
}


