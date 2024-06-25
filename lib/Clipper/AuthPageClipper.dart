import 'package:flutter/material.dart';

class AuthPageClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height *0.45);
    path.quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.45,
        size.width *0.45,
        size.height * 0.55
    );
    path.quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.7,
        size.width,
        size.height * 0.6
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}