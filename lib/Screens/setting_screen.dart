import 'package:ai_chatbot/Provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static String id = 'settingScreen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Setting'),),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Consumer<SettingsProvider>(builder: (context, value, child) => ListTile(
                  title: Text('Dark Theme'),
                  trailing: Switch(onChanged: (val){
                    value.setSwitchValue(val);
                    value.changeTheme();
                    }, value: value.switchValue, activeColor: Colors.yellow,),
                  tileColor: Theme.of(context).colorScheme.primary,
                  // titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),),
                const SizedBox(height: 20,),
                Consumer<SettingsProvider>(builder: (context, value, child) => ListTile(
                  title: Text('Change Voice'),
                  trailing: DropdownButton(
                    onChanged: (val){
                      value.setCurrentLanguageValue(val);
                      value.changeVoice();
                      },
                    items: value.items.map((String items){return DropdownMenuItem(value: items,child: Text(items),);}).toList(), hint: const Text('Select'),
                    value: value.currentLanguageValue,
                    elevation: 3,
                    icon: Icon(Icons.arrow_drop_down_sharp, size: 30,),
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                  ),
                  tileColor: Theme.of(context).colorScheme.primary,
                  // titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),),
                const SizedBox(height: 20,),
              ],
            ),
          )
      ),
    );
  }
}

