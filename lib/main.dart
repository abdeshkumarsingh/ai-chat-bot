import 'package:ai_chatbot/Provider/auth_service_provider.dart';
import 'package:ai_chatbot/Provider/chat_services_provider.dart';
import 'package:ai_chatbot/Provider/settings_provider.dart';
import 'package:ai_chatbot/Provider/text_to_speech_provider.dart';
import 'package:ai_chatbot/Provider/user_provider.dart';
import 'package:ai_chatbot/Screens/about_us.dart';
import 'package:ai_chatbot/Screens/auth_stream.dart';
import 'package:ai_chatbot/Screens/chat_history_screen.dart';
import 'package:ai_chatbot/Screens/gemini_screen.dart';
import 'package:ai_chatbot/Screens/home_screen.dart';
import 'package:ai_chatbot/Screens/login_screen.dart';
import 'package:ai_chatbot/Screens/profile_screen.dart';
import 'package:ai_chatbot/Screens/reset_password_screen.dart';
import 'package:ai_chatbot/Screens/setting_screen.dart';
import 'package:ai_chatbot/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthServiceProvider(),),
      ChangeNotifierProvider(create: (context) => ChatServicesProvider(),),
      ChangeNotifierProvider(create: (context) => TextToSpeechProvider(),),
      ChangeNotifierProvider(create: (context) => SettingsProvider(),),
      ChangeNotifierProvider(create: (context) => UserProvider(),)
    ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, value, child) => MaterialApp(
      theme: value.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: AuthStream.id,
      routes: {
        AuthStream.id : (context) => const AuthStream(),
        HomeScreen.id : (context) => const HomeScreen(),
        LoginScreen.id : (context) => const LoginScreen(),
        SignupScreen.id : (context) => const SignupScreen(),
        AboutUs.id : (context) => const AboutUs(),
        ChatHistoryScreen.id : (context) => const ChatHistoryScreen(),
        GeminiScreen.id : (context) => const GeminiScreen(),
        ResetPasswordScreen.id : (context) => const ResetPasswordScreen(),
        SettingScreen.id: (context) => const SettingScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
      },
    ),);
  }
}








