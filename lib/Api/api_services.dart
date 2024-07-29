import 'package:ai_chatbot/Model/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ApiServices {

  static const api_key = 'AIzaSyCoPyFhjqeK8bhBPFjFqI_faAJn5VVvhaE';

  final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: api_key,
      generationConfig: GenerationConfig(maxOutputTokens: 1000),
  );

  Future<String?> geminiResponse(String question, XFile? file, List<Message> message) async{
    final image = await file?.readAsBytes();
    final prompt = TextPart(question);
    final messages = message;
    List<Content> history = [];

   if(history.isEmpty){
     for(int i = 0; i < messages.length; i++){
       final message = messages[i];
       if(message.senderName != 'bot'){
         history.add(Content.text(message.content));
       } else {
         history.add(Content.model([TextPart(message.content)]));
       }
     }
   }

    if (file != null) {
      // Read image file as bytes

      // Prepare prompt and image parts
      final imageParts = [
        DataPart('image/jpeg', image!),
      ];

      // Generate content using the model
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts]), // Spread imageParts to include all parts
      ]);
      // Return the generated response text
      return response.text;
    } else if(question.isNotEmpty){
      try{
        final chat = model.startChat(history: history);
        var content = Content.text(question);
        var response = await chat.sendMessage(content);
        history.add(content);
        history.add(Content.model([TextPart(response.text!)]));
        return response.text;

      } on GenerativeAIException catch (e){
        return e.message.toString();
      }
    } else return 'Nothing to say';
  }
}