import 'package:bizzie_co/utils/clippers/clipper_primary.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget {
  const PrimaryContainer({
    Key? key,
    required this.height,
    required this.width,
    this.containerHeight = 0.3,
    this.padding = 90,
  }) : super(key: key);

  final double height;
  final double width;
  final double containerHeight;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: SignUpClipperPrimary(height: height, width: width),
        child: Container(
          height: containerHeight * height,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              // color: primary,
              gradient: upperContainer),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: padding).copyWith(bottom: 25),
            child: Image.asset(
              'assets/images/bizzieco_logo.png',
              // fit: BoxFit.fitWidth,
              // scale: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
