// import 'package:ai_chatbot/Provider/slider_provider.dart';
// import 'package:ai_chatbot/Screens/count_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SliderScreen extends StatelessWidget {
//   const SliderScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final sliderProvider = Provider.of<SliderProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(title: Text('Slider'),),
//       body: Consumer<SliderProvider>(builder: (context, value, child) => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Slider(value: value.sliderValue, onChanged: (value){
//             sliderProvider.setSliderValue(value);
//           }),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(height: 150, width: 150, color: Colors.yellow.withOpacity(sliderProvider.sliderValue),),
//               SizedBox(width: 20,),
//               Container(height: 150, width: 150, color: Colors.red.withOpacity(sliderProvider.sliderValue),),
//             ],
//           ),
//           ElevatedButton(child: Text('Counter'), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CountScreen(),));},),
//         ],
//       ),
//       ),
//     );
//   }
// }
