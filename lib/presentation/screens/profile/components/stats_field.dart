import 'package:bizzie_co/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsField extends StatelessWidget {
  const StatsField({
    Key? key,
    required this.width,
    required this.user,
  }) : super(key: key);

  final User user;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: width / 3.5,
          child: Column(
            children: [
              Text('${user.numOfConnections}',
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Text('Connections',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
        ),

        // TODO : work on number of card shares
        /*  Container(
          height: 40.0,
          width: 0.5,
          color: Colors.black26,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        SizedBox(
          width: width / 3.5,
          child: Column(
            children: [
              Text('85',
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Text('Likes',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        Container(
          height: 40.0,
          width: 0.5,
          color: Colors.black26,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        SizedBox(
          width: width / 3.5,
          child: Column(
            children: [
              Text('50',
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Text('Card Shares',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
        ), */
      ],
    );
  }
}
