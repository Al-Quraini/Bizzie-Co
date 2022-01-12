import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'events_title.dart';

class FeaturedEvents extends StatelessWidget {
  const FeaturedEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const EventsTitle(
          title: 'Featured Events',
        ),
        AspectRatio(
          aspectRatio: 11 / 6,
          child: Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            padding: const EdgeInsets.all(20),
            width: width,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Boston Convention Center',
                        style: GoogleFonts.quicksand(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Text(
                  'AI Conference',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'July 20th, 2022  2 PM - 8 PM',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
