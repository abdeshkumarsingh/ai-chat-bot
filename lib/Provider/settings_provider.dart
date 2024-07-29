import 'package:ai_chatbot/Components/theme.dart';
import 'package:ai_chatbot/Provider/text_to_speech_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier{
  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    textToSpeechProvider.dispose();
  }

  TextToSpeechProvider textToSpeechProvider = TextToSpeechProvider();
  List<String> _items = ['Hindi', 'English'];
  String? _currentLanguageValue;
  bool _switchVal = true;
  ThemeData _theme = darkMode;

  bool get switchValue => _switchVal;
  String? get currentLanguageValue => _currentLanguageValue;
  List<String> get items => _items;


  ThemeData get theme => _theme;

  void changeTheme(){
    if(_theme == lightMode){
      _theme = darkMode;
    } else {
      _theme = lightMode;
    }
    notifyListeners();
  }

  void setCurrentLanguageValue(String? value){
    notifyListeners();
    _currentLanguageValue = value;
  }

  void setSwitchValue(bool value){
    notifyListeners();
    _switchVal = value;
  }

  void changeVoice(){
    if(_currentLanguageValue == 'Hindi'){
      textToSpeechProvider.setVoice('hi');
      notifyListeners();
    }
    if(_currentLanguageValue == 'English'){
      textToSpeechProvider.setVoice('en-US');
      notifyListeners();
    }
  }
}