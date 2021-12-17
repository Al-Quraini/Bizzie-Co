import 'package:flutter/material.dart';

class SignUpClipperPrimary extends CustomClipper<Path> {
  final double height;
  final double width;

  SignUpClipperPrimary({required this.height, required this.width});
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, size.height - 0.05 * height);

    final Offset firstControlPoint =
        Offset(size.width / 4, size.height - 0.12 * height);
    final Offset firstEndPoint =
        Offset(size.width / 2, size.height - 0.05 * height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final Offset secondControlPoint =
        Offset(size.width - (size.width / 4), size.height + 0.03 * height);
    final Offset secondEndPoint =
        Offset(size.width, size.height - 0.04 * height);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
