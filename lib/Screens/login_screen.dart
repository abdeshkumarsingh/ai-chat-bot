import 'package:ai_chatbot/Clipper/AuthPageClipper.dart';
import 'package:ai_chatbot/Components/auth_textfield.dart';
import 'package:ai_chatbot/Screens/reset_password_screen.dart';
import 'package:ai_chatbot/Screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    bool _isPassword = false;
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
                      padding: const EdgeInsets.all(16.0),
                      child: Image(image: AssetImage('assets/images/login-image.png'), height: 300,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          AuthTextField(hintText: 'Enter your email', icon: Icons.mail, onChanged: (value) {},),
                          SizedBox(height: 20,),
                          AuthTextField(hintText: 'Enter Your Password', icon: Icons.key_outlined, isPassword: _isPassword, onChanged: (value) {}, suffixIcon: IconButton(icon: Icon(_isPassword? Icons.visibility_off : Icons.visibility), onPressed: (){setState(() {
                            _isPassword = !_isPassword;
                          });},),),
                          Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),)); }, child: Text('Forget password?', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 16),),),),
                          ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                                  },
                              )
                            ]
                        )),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){}, child: Text('Log In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.black45)),),
                    Divider(thickness: 2, color: Colors.blueGrey,indent: 100, endIndent: 100,height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: IconButton(onPressed: (){}, icon: Image.asset('assets/images/google.png')),
                        ),
                        SizedBox(width: 20,),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: IconButton(onPressed: (){}, icon: Image.asset('assets/images/facebook.png')),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
