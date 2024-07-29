import 'package:ai_chatbot/Model/message.dart';
import 'package:ai_chatbot/Provider/text_to_speech_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget MessageItem (Message message){

  bool _isUser = false;

  if(message.senderName != 'bot'){
    _isUser = true;
  } else {
    _isUser = false;
  }

  if (message.imageUrl != null) {
    // Code to create message with image
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: _isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: _isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!_isUser) Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(child: Image.asset('assets/images/gemini-logo.png')),
              ),
              Flexible(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(topLeft: _isUser ? Radius.circular(10) : Radius.circular(0), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: _isUser ? Radius.circular(0) : Radius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(message.content),
                        SizedBox(height: 8),
                        if(_isUser) Image.network(message.imageUrl!),
                        Consumer<TextToSpeechProvider>(builder: (context, value, child) => InkWell(
                          child: Icon(
                              value.isSpeaking ? Icons.volume_off : Icons.volume_up
                          ),
                          onTap: (){
                            value.isSpeaking ? value.stop() : value.speak(message.content);
                          },
                        ),)
                      ],
                    ),
                  ),

                ),
              ),
              if(_isUser) Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(child: Image.asset('assets/images/profile.png')),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(message.senderName,),
          ),
        ],
      ),
    );
  }
  //Chatbox without image code here
  else {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: _isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: _isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!_isUser) Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(child: Image.asset('assets/images/gemini-logo.png')),
              ),
              Flexible(
                child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.only(topLeft: _isUser ? Radius.circular(10) : Radius.circular(0), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: _isUser ? Radius.circular(0) : Radius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: _isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(message.content),
                          Consumer<TextToSpeechProvider>(builder: (context, value, child) => InkWell(
                            child: Icon(
                                value.isSpeaking ? Icons.volume_off : Icons.volume_up,
                            ),
                            onTap: (){
                              value.isSpeaking ? value.stop() : value.speak(message.content);
                            },
                          ),)
                        ],
                      ),
                    )
                ),
              ),
              if(_isUser) Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(child: Image.asset('assets/images/profile.png')),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(message.senderName,),
          )
        ],
      ),
    );
  }
}
