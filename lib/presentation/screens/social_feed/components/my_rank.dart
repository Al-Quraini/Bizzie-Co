import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRank extends StatelessWidget {
  const MyRank({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    String rankText = '';

    switch (user.ranking) {
      case null:
        rankText = '\t\tnot determined ';
        break;

      case 1:
        rankText = '\t\t${user.ranking}st ';
        break;
      case 2:
        rankText = '\t\t${user.ranking}nd ';
        break;
      case 3:
        rankText = '\t\t${user.ranking}rd ';
        break;
      default:
        rankText = '\t\t${user.ranking}th ';
        break;
    }
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8)
          .copyWith(left: width / 10),
      height: 100,
      width: width,
      decoration: BoxDecoration(
          gradient: primaryGredient, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: user.imagePath != null
                    ? NetworkImage(
                        user.userImage!,
                      )
                    : placeholer,
              ),
              border: Border.all(color: const Color(0xFF6736CE), width: 5),
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Your rank',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      )),
                  TextSpan(
                    text: rankText,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  // TextSpan(
                  //   text: '\tof 1 Mil',
                  //   style: GoogleFonts.poppins(
                  //     color: Colors.white,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                ]),
          ),
        ],
      ),
    );
  }
}
