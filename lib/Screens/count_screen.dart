// import 'dart:async';
// import 'package:ai_chatbot/Provider/count_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class CountScreen extends StatefulWidget {
//   const CountScreen({super.key});
//
//   @override
//   State<CountScreen> createState() => _CountScreenState();
// }
//
// class _CountScreenState extends State<CountScreen> {
//
//   @override
//   @override
//   void initState() {
//     final countProvider = Provider.of<CountProvider>(context, listen: false);
//     Timer.periodic(Duration(seconds: 2), (timer){
//       // countProvider.setCount();
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final countProvider = Provider.of<CountProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(title: Text('Counter'), centerTitle: true,),
//       body: Consumer<CountProvider>(builder: (context, value, child) => Center(
//         child: Text(value.count.toString()),
//       ),),
//       floatingActionButton: FloatingActionButton(onPressed: () { countProvider.setCount(); }, child: Icon(Icons.add), backgroundColor: Colors.blue,),
//     );
//   }
// }
