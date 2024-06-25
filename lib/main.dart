
import 'package:ai_chatbot/Screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => SliderProvider()),
    //     ChangeNotifierProvider(create: (context) => CountProvider(),),
    //   ],
    //   child:
      MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF465D82),
          appBarTheme: const AppBarTheme(centerTitle: true, color: Color(0xFF465D82))
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(
          child: HomeScreen(),
        ),
      // ),
    );
  }
}








