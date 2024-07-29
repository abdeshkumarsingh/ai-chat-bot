import 'dart:io';
import 'package:ai_chatbot/Components/show_image_picker.dart';
import 'package:ai_chatbot/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_chatbot/Api/api_services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ChatServicesProvider with ChangeNotifier {


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    textController.dispose();
    _textRecognizer.close();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  TextEditingController textController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  String _chatSession = '';
  String _errorMsg = '';
  bool? isError;
  InputImage? _inputImage;
  List<Message>? _messages;


  void setMessages(List<Message> messages) {
    _messages = messages;
  }

  ScrollController get scrollController => _scrollController;

  String get errorMsg => _errorMsg;

  XFile? get selectedImage => _selectedImage;

  String get chatSession => _chatSession;

  void setChatSession(String chatSession){
    _chatSession = chatSession;
    notifyListeners();
  }

  void clearImage(){
    _selectedImage = null;
    notifyListeners();
  }

  void scrollToBottom(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 2), curve: Curves.easeOut);
  }

  Future<void> textExtractor(String mode) async{
    //this condition only activate while input method is gallery
    if(mode == 'gallery'){
     await selectImageFromGalery();
     if(_selectedImage != null){
       _inputImage = InputImage.fromFilePath(_selectedImage!.path);
       final RecognizedText recognizedText = await _textRecognizer.processImage(_inputImage!);
       clearImage();
       textController.text = recognizedText.text;
       notifyListeners();
     } else {
       return;
     }
    }
    //this condition only activate while input method is camera
    if(mode == 'camera'){
      await selectImageFromCamera();
      if(_selectedImage != null){
        _inputImage = InputImage.fromFilePath(_selectedImage!.path);
        final RecognizedText recognizedText = await _textRecognizer.processImage(_inputImage!);
        clearImage();
        textController.text = recognizedText.text;
        notifyListeners();
      } else {
        return;
      }
    }
  }

   showImagePicker(String mode, BuildContext context){
    showBottomSheet(context: context, builder: (BuildContext context){
      return ShowImagePicker(mode: mode);
    });
  }

  Future<void> selectImageFromGalery() async{
     try{
       _errorMsg = '';
       final image = await _picker.pickImage(source: ImageSource.gallery);
       if(image == null){
         return;
       }
       _selectedImage = image;
       await _cropImage();
       notifyListeners();
     } catch (e){
       _errorMsg = e.toString();
     }
  }

  Future<void> selectImageFromCamera() async {
    try {
      _errorMsg = '';
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        _errorMsg = 'image is not selected';
        return;
      }
      _selectedImage = image;
      await _cropImage();
      notifyListeners();
    } catch (e) {
      // Handle any errors here
      _errorMsg = e.toString();
    }
  }

  Future<void> _cropImage() async {
    try {
      _errorMsg = '';
      if (_selectedImage != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: _selectedImage!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ],
            ),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ],
            ),
          ],
        );
        if (croppedFile != null) {
          _selectedImage = XFile(croppedFile.path);
        }
      }
      notifyListeners();
    } catch (e) {
      // Handle any errors here
      _errorMsg = e.toString();
    }
  }


  Future<void> createChatSession(String userId) async {
    try{
      _errorMsg = '';
      await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chatSessions')
        .add({
      'created_at': FieldValue.serverTimestamp(),
    });
    notifyListeners();
    } on FirebaseException catch (e){
      _errorMsg = e.message.toString();
    }
  }

  Future<void> deleteChatSession(String userId, String sessionId) async {
    try{
      _errorMsg = '';
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('chatSessions')
          .doc(sessionId)
          .delete();
      notifyListeners();
    } on FirebaseException catch(e){
      _errorMsg = e.message.toString();
    }
  }

  Stream<List<ChatSession>> getChatSessions(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chatSessions')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map((doc) => ChatSession.fromDocument(doc))
            .toList());
  }

  void sendResponse(String userId, String sessionId, String userName, XFile? image, String query) async{
    ApiServices apiServices = ApiServices();
    String? imageUrl;
    XFile? geminiImage = image;
    String geminiQuery = query;
    if (geminiImage != null) {
      imageUrl = await uploadImage(geminiImage);
    }
    clearImage();
    textController.clear();
    await sendMessage(userId, sessionId, geminiQuery, imageUrl, userName);
    final geminiResponse = await apiServices.geminiResponse(geminiQuery, geminiImage, _messages!);
    if(geminiResponse != null){
      await sendMessage(userId, sessionId, geminiResponse, imageUrl, 'bot');
    }
    scrollToBottom();
    notifyListeners();
  }

  Future<void> sendImage(String userId, String chatSessionId) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageUrl = await uploadImage(image);
      await sendMessage(userId, chatSessionId, '', imageUrl, '');
    }
    notifyListeners();
  }

  Future<String> uploadImage(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('chat_images/${image.name}');
      final uploadTask = storageRef.putFile(File(image.path));
      final snapshot = await uploadTask;
      notifyListeners();
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      notifyListeners();
      rethrow; // Re-throw the error to handle it in the UI
    }
  }

  Stream<List<Message>> getMessages(String userId, String chatSessionId) {
    Stream<List<Message>> messages = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chatSessions')
        .doc(chatSessionId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Message.fromDocument(doc)).toList());

    return messages;
  }

  Future<void> sendMessage(String userId, String chatSessionId, String content, String? imageUrl, String senderName) async {
    final message = Message(
      content: content,
      senderId: userId,
      timestamp: Timestamp.now(),
      imageUrl: imageUrl,
      senderName: senderName,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chatSessions')
        .doc(chatSessionId)
        .collection('messages')
        .add(message.toMap());
    notifyListeners();
  }
}

class ChatSession {
  final String id;
  final Timestamp createdAt;

  ChatSession({required this.id, required this.createdAt});

  factory ChatSession.fromDocument(DocumentSnapshot doc) {
    return ChatSession(
      id: doc.id,
      createdAt: doc['created_at'],
    );
  }
}

