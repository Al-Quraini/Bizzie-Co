import 'package:bizzie_co/utils/clippers/corner_clipper.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItem extends StatelessWidget {
  const CardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Container(
      // height: 50,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                color: Colors.grey[300]!,
                offset: const Offset(-2, 2))
          ]),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: ClipPath(
                  clipper: CornerClipper(height: 55, width: 100),
                  child: Container(
                    height: 30,
                    width: 30,
                    color: cardCornerBlue,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jessica Jones ',
                              style: GoogleFonts.poppins(
                                fontSize: 4,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('AI Real Estate',
                              style: GoogleFonts.poppins(
                                fontSize: 4,
                                fontWeight: FontWeight.w500,
                              )),
                          Text('BOSTON, MA',
                              style: GoogleFonts.poppins(
                                fontSize: 4,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/qrcode.png'))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text('(123) 456 - 7890',
                      style: GoogleFonts.poppins(
                        fontSize: 5,
                        fontWeight: FontWeight.w500,
                      )),
                  Text('johndoe@airealestate.com',
                      style: GoogleFonts.poppins(
                        fontSize: 5,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
