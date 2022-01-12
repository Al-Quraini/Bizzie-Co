import 'package:bizzie_co/utils/clippers/clipper_primary.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget {
  const PrimaryContainer({
    Key? key,
    required this.containerHeight,
    this.padding = 90,
  }) : super(key: key);

  final double containerHeight;
  final double padding;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: SignUpClipperPrimary(height: height, width: width),
        child: Container(
          height: containerHeight,
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
