import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingListItem extends StatelessWidget {
  const SettingListItem({
    Key? key,
    required this.title,
    this.onPress,
    this.color = Colors.black,
  }) : super(key: key);

  final String title;
  final Function()? onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen
    return Padding(
        padding: EdgeInsets.fromLTRB(width / 10, 0, 0, 10),
        child: TextButton(
          onPressed: onPress,
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
          child: Text(title,
              style: GoogleFonts.poppins(
                  color: color, fontSize: 17, fontWeight: FontWeight.w300)),
        ));
  }
}
