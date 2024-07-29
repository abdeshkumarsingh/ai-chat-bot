import 'package:ai_chatbot/Provider/chat_services_provider.dart';
import 'package:ai_chatbot/Screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});
  static String id = 'chatHistoryScreen';

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<ChatServicesProvider>(builder: (context, value, child) => StreamBuilder<List<ChatSession>>(
          stream: value.getChatSessions(userId!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var chatSessions = snapshot.data!;
            return ListView.builder(
              itemCount: chatSessions.length,
              itemBuilder: (context, index) {
                var chatSession = chatSessions[index];

                return Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: ListTile(
                    dense: true,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Text('Chat Session ${chatSession.id}'),
                    subtitle: Text('Created at: ${chatSession.createdAt.toDate()}'),
                    onTap: () {
                      value.setChatSession(chatSession.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(chatSession: chatSession.id,)),
                      );
                    },
                    tileColor: Theme.of(context).colorScheme.primary,
                    trailing: InkWell(
                      child: Icon(Icons.delete),
                      onTap: ()async{
                        await value.deleteChatSession(userId!, chatSession.id);
                      },
                    ),
                    leading: CircleAvatar(
                      child: Image.asset('assets/images/gemini-logo.png'),
                    ),
                  ),
                );
              },
            );
          },
        ),
        )
      ),
      floatingActionButton: Consumer<ChatServicesProvider>(builder: (context, value, child) => FloatingActionButton(
        onPressed: (){
          value.createChatSession(userId!);
        },
        child: Icon(Icons.add,),
        elevation: 2,
      ),),
    );
  }
}
