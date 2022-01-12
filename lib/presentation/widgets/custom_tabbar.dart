import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> stringValues;
  final List<IconData> iconValues;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  const CustomTabBar({
    Key? key,
    required this.stringValues,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    required this.iconValues,
  }) : super(key: key);
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  bool initialPosition = true;
  int selectedIndex = 0;

  List<Alignment> alignmets = [Alignment.bottomLeft, Alignment.bottomRight];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      // switch position
      width: width * 1,
      // height: width * 0.2,
      alignment: Alignment.center,
      // margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            // back container dimensions
            width: width * 1,
            // height: width * 0.2,

            // Tabs
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                widget.stringValues.length,
                (index) => InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    widget.onToggleCallback(index);
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    // height: width * 0.1,
                    width: width * 0.5,
                    alignment: Alignment.center,

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            widget.iconValues[index],
                            color: index == selectedIndex
                                ? activeIndicator
                                : Colors.black45,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.stringValues[index],
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: index == selectedIndex
                                  ? FontWeight.w900
                                  : FontWeight.w800,
                              color: index == selectedIndex
                                  ? activeIndicator
                                  : Colors.black45,
                            ),
                          ),
                        ],
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
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: width * 0.4,
              height: 3,
              color: primary,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
