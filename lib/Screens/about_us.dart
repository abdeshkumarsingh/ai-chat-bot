import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  static String id = 'aboutUsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('About Us'),),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/myimage.jpeg'),
              ),
              SizedBox(height: 30,),
              Text(
                'Abdesh Singh',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Rye'
                ),
              ),
              Text(
                'Flutter Developer',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontFamily: 'Silkscreen'
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  thickness: 2,
                ),
              ),
              Card(
                elevation: 2,
                color: Theme.of(context).colorScheme.primary,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListTile(
                  leading: Icon(
                    Icons.add_ic_call,
                  ),
                  title: Text('+977 9803562401',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.primary,
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                  ),
                  title: Text('abdeshis4u@gmail.com',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}