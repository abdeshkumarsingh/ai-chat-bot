import 'package:ai_chatbot/Components/auth_textfield.dart';
import 'package:ai_chatbot/Components/message_item.dart';
import 'package:ai_chatbot/Model/message.dart';
import 'package:ai_chatbot/Model/user_model.dart';
import 'package:ai_chatbot/Provider/auth_service_provider.dart';
import 'package:ai_chatbot/Provider/chat_services_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ChatScreen extends StatefulWidget {
  final String chatSession;
  static String id = 'chatScreen';

  ChatScreen({required this.chatSession});
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    if (widget.chatSession.isEmpty || widget.userId == null) {
      return Scaffold(
        body: Center(child: Text('Invalid chat session or user not logged in')),
      );
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.arrow_downward), onPressed: (){Provider.of<ChatServicesProvider>(context, listen: false).scrollToBottom();}, ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(context, widget.userId!, widget.chatSession),
          ),
          _buildMessageInput(context, widget.userId!, widget.chatSession),
        ],
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context, String userId, String sessionId) {
    final chatServiceProvider = Provider.of<ChatServicesProvider>(context, listen: false);
        return StreamBuilder<List<Message>>(
          stream: chatServiceProvider.getMessages(userId, sessionId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No messages found.'));
            }

            final messages = snapshot.data!;
            chatServiceProvider.setMessages(messages);
            return ListView.builder(
              controller: Provider.of<ChatServicesProvider>(context, listen: false).scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageItem(message);
              },
            );
          },
        );
  }



  Widget _buildMessageInput(BuildContext context, String userId, String sessionId) {
    final authProvider = Provider.of<AuthServiceProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ChatServicesProvider>(builder: (context, value, child) => Column(
        children: [
          if (value.selectedImage != null)
            Stack(
              children: [
                Image.file(
                  File(value.selectedImage!.path),
                  height: 150,
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      value.clearImage();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: AuthTextField(
                  icon: Icons.keyboard,
                  hintText: 'Enter your Question here',
                  controller: value.textController,),
                // child: TextField(
                //   controller: value.textController,
                //   decoration: InputDecoration(hintText: 'Enter your question here...', fillColor: Colors.white, filled: true, prefix: InkWell(child: Icon(Icons.camera_alt, color: Colors.grey,), onTap: ()async {await value.selectImageFromCamera();},)),
                // ),
              ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () async {
                          await value.showImagePicker('', context);
                          if(value.errorMsg.isNotEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.errorMsg)));
                          }
                        },
                      ),
                      IconButton(onPressed: () async{
                        await value.showImagePicker('active', context);
                        if(value.errorMsg.isNotEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.errorMsg)));
                        }
                      },
                          icon: Icon(Icons.document_scanner)
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          final user = await authProvider.getUserModel();
                          final userName = user.userName;
                          if(value.textController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Field can\'t be blank.'), backgroundColor: Colors.red));
                            return;
                          } else {
                            value.sendResponse(userId, sessionId, userName!, value.selectedImage ,value.textController.text);
                          }

                          if(value.errorMsg.isNotEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.errorMsg)));
                          }
                        },
                      ),
                    ],
                  )
            ],
          ),
        ],
      ),
      ),
    );
  }
}
