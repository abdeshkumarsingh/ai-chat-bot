import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final String senderId;
  final Timestamp timestamp;
  final String? imageUrl;
  final String senderName;

  Message({
    required this.content,
    required this.senderId,
    required this.timestamp,
    this.imageUrl,
    required this.senderName
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      content: data['content'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      imageUrl: data['imageUrl'], // This field is optional
      senderName: data['senderName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
      'senderName': senderName,
    };
  }
}

