import 'package:ai_chatbot/Provider/chat_services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ShowImagePicker extends StatelessWidget {
  String? mode;
  ShowImagePicker({this.mode});
    @override
    Widget build(BuildContext context) {
      final _chatProvider = Provider.of<ChatServicesProvider>(context, listen: false);
        return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () async{
                      if(mode!.isEmpty){
                       await _chatProvider.selectImageFromGalery();
                      } else {
                        _chatProvider.textExtractor('gallery');
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () async{
                      if(mode!.isEmpty){
                       await _chatProvider.selectImageFromCamera();
                      } else {
                        _chatProvider.textExtractor('camera');
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
    }
  }

