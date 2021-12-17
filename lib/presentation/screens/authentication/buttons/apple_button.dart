import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class AppleButton extends StatelessWidget {
  const AppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen

    return // Sign in with facebook
        Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 10, vertical: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.grey,
              elevation: 5,
              primary: appleButtonBackground,
              fixedSize: Size(MediaQuery.of(context).size.width, 55)),
          onPressed: () async {},
          child: LayoutBuilder(builder: (context, constraint) {
            return Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      FontAwesomeIcons.apple,
                      color: Colors.white,
                    ),
                  ),
                ),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                  color: Colors.white38,
                ),
                SizedBox(
                  width: constraint.maxWidth / 1.5,
                  child: AutoSizeText(
                    '   continue with Apple  ',
                    maxLines: 1,
                    maxFontSize: 16,
                    minFontSize: 12,
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
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
