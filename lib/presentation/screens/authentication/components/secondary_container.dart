import 'package:bizzie_co/utils/clippers/clipper_secondary.dart';
import 'package:flutter/material.dart';

class SecondaryContainer extends StatelessWidget {
  const SecondaryContainer({
    Key? key,
    this.containerHeight = 0.71,
  }) : super(key: key);

  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: SignUpClipperSecondary(height: height, width: width),
        child: Container(
          height: containerHeight,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[200],
          ),
        ),
      ),
    );
  }
}
