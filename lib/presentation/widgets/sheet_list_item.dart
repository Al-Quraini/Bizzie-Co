import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SheetItemList extends StatelessWidget {
  const SheetItemList({
    Key? key,
    required this.title,
    this.onPress,
    this.color = Colors.black,
    this.description,
  }) : super(key: key);

  final String title;
  final Function()? onPress;
  final Color color;
  final String? description;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      child: Column(
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  color: color, fontSize: 15, fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 5,
          ),
          if (description != null)
            Text(description!,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w200)),
        ],
      ),
    );
  }
}
