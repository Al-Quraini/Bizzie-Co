import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.title,
    this.onPress,
  }) : super(key: key);

  final String title;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: 0.705 * width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 5, color: Colors.grey, offset: Offset(-3, 6))
        ],
        gradient: authButtonGredient,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(title,
            style: GoogleFonts.quicksand(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            minimumSize: Size(width * .7, height * .05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
