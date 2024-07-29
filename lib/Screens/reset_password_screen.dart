import 'package:ai_chatbot/Clipper/AuthPageClipper.dart';
import 'package:ai_chatbot/Components/auth_textfield.dart';
import 'package:ai_chatbot/Provider/auth_service_provider.dart';
import 'package:ai_chatbot/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static String id = 'resetPwdScreen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isPassword = false;
  TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF465D82),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              ClipPath(
                clipper: AuthPageClipper(),
                child: Container(
                  height: 700,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(stops: [0.57,1], begin: Alignment.bottomRight, end: Alignment.topLeft, colors: [Colors.blueGrey,Color(0xFF6F7E97)])
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 50),
                    child: Image(image: AssetImage('assets/images/resetpwd-image.png'), height: 300,),
                  ),
                  Text('Please enter your email to get reset link', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        AuthTextField(hintText: 'Enter your email', icon: Icons.mail, onChanged: (value) {}, controller: _emailcontroller,),
                        SizedBox(height: 20,),
                        ],
                    ),
                  ),
                  Consumer<AuthServiceProvider>(builder: (context, value, child) => ElevatedButton(onPressed: () async{
                    try {
                      await value.resetPassword(_emailcontroller.text);
                      if (value.isErrorMessage) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value.resetPasswordMessage)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password reset email sent successfully.')),
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An unexpected error occurred. Please try again later.')),
                      );
                    }
                  }, child: Text('Reset', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.black45)),),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
