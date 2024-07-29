import 'package:ai_chatbot/contants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  Widget logoPath;
  String cardName;
  GestureTapCallback onTap;

  HomeScreenCard({super.key, required this.cardName, required this.logoPath, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoPath,
                SizedBox(height: 16,),
                Text(cardName, style: kCardTextStyle)
              ],
            ),
          ),
      onTap: onTap,
    );
  }
}