import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SponsorsTab extends StatelessWidget {
  const SponsorsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('Event Sponsors',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
        GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width / 5,
                childAspectRatio: 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 20),
            itemCount: 10,
            itemBuilder: (BuildContext ctx, index) {
              return Column(
                children: [
                  const Expanded(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Text('Name',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300)),
                  ),
                ],
              );
            }),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
