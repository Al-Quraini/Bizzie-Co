import 'package:bizzie_co/utils/clippers/clipper_secondary.dart';
import 'package:flutter/material.dart';

class SecondaryContainer extends StatelessWidget {
  const SecondaryContainer({
    Key? key,
    required this.height,
    required this.width,
    this.containerHeight = 0.33,
  }) : super(key: key);

  final double height;
  final double width;
  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: SignUpClipperSecondary(height: height, width: width),
        child: Container(
          height: containerHeight * height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[200],
          ),
        ),
      ),
    );
  }
}
