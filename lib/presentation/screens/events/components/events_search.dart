import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsSearch extends StatelessWidget {
  const EventsSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[300]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.4],
            tileMode: TileMode.clamp,
          ),
          border: Border.all(color: Colors.grey[200]!, width: 1),
          borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            hintStyle: GoogleFonts.quicksand(),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black87,
            )),
      ),
    );
  }
}
