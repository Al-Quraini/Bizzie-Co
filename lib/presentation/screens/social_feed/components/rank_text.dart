import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RrankText extends StatelessWidget {
  const RrankText({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: title,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: ' \t-\t ',
                    style: GoogleFonts.poppins(
                        color: Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text: 'Top 10',
                    style: GoogleFonts.poppins(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
