import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  String logoPath;
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
                color: Color(0xFF3B4C68)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(logoPath, height: 80,),
                SizedBox(height: 16,),
                Text(cardName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Roboto Slab'),)
              ],
            ),
          ),
      onTap: onTap,
    );
  }
}