import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsTitle extends StatelessWidget {
  const EventsTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
