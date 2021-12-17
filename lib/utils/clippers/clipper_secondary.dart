import 'package:flutter/material.dart';

class SignUpClipperSecondary extends CustomClipper<Path> {
  final double height;
  final double width;

  SignUpClipperSecondary({required this.height, required this.width});
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 6, size.height - 0.02 * height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 4, size.height - 0.06 * height);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 2), size.height - 0.20 * height);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
