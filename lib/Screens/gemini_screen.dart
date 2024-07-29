import 'package:ai_chatbot/Provider/chat_services_provider.dart';
import 'package:ai_chatbot/Screens/chat_history_screen.dart';
import 'package:ai_chatbot/Screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});
  static String id = 'geminiScreen';

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {


  int _currentIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const ChatHistoryScreen(),
      ChatScreen(chatSession: Provider.of<ChatServicesProvider>(context, listen: false).chatSession,),
    ];
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: (index){
            _currentIndex = index;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Chat History'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat')
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      ),
      appBar: AppBar(title: Text('Gemini Bot',),),
    );
  }
}
