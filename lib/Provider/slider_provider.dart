import 'package:flutter/widgets.dart';

class SliderProvider extends ChangeNotifier{
  double _sliderValue = 0.6;

  double get sliderValue => _sliderValue;

  void setSliderValue(double value){
    this._sliderValue = value;
    notifyListeners();
  }
}