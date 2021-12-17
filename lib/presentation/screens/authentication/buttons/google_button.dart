import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, this.onPress}) : super(key: key);

  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 10, vertical: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.grey,
              elevation: 5,
              primary: googleButtonBackground,
              fixedSize: Size(width, 55)),
          onPressed: onPress,
          child: LayoutBuilder(builder: (context, constraint) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/google_logo.png',
                    height: 30,
                    width: 30,
                  ),
                ),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(
                  width: constraint.maxWidth / 1.5,
                  child: AutoSizeText(
                    '   continue with Google   ',
                    maxLines: 1,
                    maxFontSize: 16,
                    minFontSize: 12,
                    style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          })),
    );
  }
}
