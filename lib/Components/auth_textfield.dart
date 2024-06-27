import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool showPassword;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final IconButton? suffixIcon;


  AuthTextField({
    this.suffixIcon,
    this.controller,
    required this.hintText,
    required this.icon,
    this.showPassword = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: showPassword,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue[900]),
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.grey[600]),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
        ),
      ),
      style: TextStyle(color: Colors.black),
    );
  }
}