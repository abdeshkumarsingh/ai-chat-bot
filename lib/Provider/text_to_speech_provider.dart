import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';


class TextToSpeechProvider with ChangeNotifier{
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String _voice = 'en-US';

  bool get isSpeaking => _isSpeaking;
  String get voice => _voice;

  void setVoice(String voice){
    _voice = voice;
  }

  TextToSpeechProvider() {
    _flutterTts.setStartHandler(() {
      _isSpeaking = true;
      notifyListeners();
    });

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });

    _flutterTts.setErrorHandler((msg) {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  Future<void> speak(String text) async {
    _isSpeaking = true;
    await _flutterTts.setLanguage(_voice);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
    _isSpeaking = false;
    notifyListeners();
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    _isSpeaking = false;
    notifyListeners();
  }
}