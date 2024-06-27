import 'package:ai_chatbot/Provider/auth_service_provider.dart';
import 'package:ai_chatbot/Screens/home_screen.dart';
import 'package:ai_chatbot/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (context) => AuthServiceProvider(),)
      ],
      child:
      MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF465D82),
          appBarTheme: const AppBarTheme(centerTitle: true, color: Color(0xFF465D82))
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}








