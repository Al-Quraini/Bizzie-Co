import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TierContainer extends StatelessWidget {
  const TierContainer({
    Key? key,
    required this.title,
    required this.level,
  }) : super(key: key);

  final String title;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(title,
                maxLines: 1,
                minFontSize: 7,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                )),
            AutoSizeText('$level+',
                maxLines: 1,
                minFontSize: 7,
                style: GoogleFonts.poppins(
                    fontSize: 10, fontWeight: FontWeight.w200)),
          ],
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2)),
      ),
    );
  }
}
