import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  const AnimatedToggle({
    Key? key,
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  }) : super(key: key);
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;
  int selectedIndex = 0;

  List<Alignment> alignmets = [
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight
  ];

  double toggleWidth = 0.3;

  @override
  void initState() {
    super.initState();

    if (widget.values.length == 2) {
      alignmets = [Alignment.centerLeft, Alignment.centerRight];
      toggleWidth = 0.4;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      // switch position
      width: width * 0.85,
      height: width * 0.1,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Container(
            // back container dimensions
            width: width * 0.85,
            height: width * 0.1,
            decoration: ShapeDecoration(
              color: widget.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.values.length,
                (index) => GestureDetector(
                  onTap: () {
                    widget.onToggleCallback(index);
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    height: width * 0.1,
                    width: width * 0.85 / 3,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      widget.values[index],
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.025,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            alignment: alignmets[selectedIndex],
            child: Container(
              margin: const EdgeInsets.all(3),
              width: width * toggleWidth,
              height: width * 0.1,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.1),
                ),
              ),
              child: Text(
                widget.values[selectedIndex],
                style: GoogleFonts.poppins(
                  fontSize: width * 0.03,
                  color: widget.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
