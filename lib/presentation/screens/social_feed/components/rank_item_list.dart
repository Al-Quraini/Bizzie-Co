import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RankItemList extends StatelessWidget {
  const RankItemList({
    Key? key,
    required this.user,
    required this.rank,
  }) : super(key: key);

  final User user;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            clipBehavior: Clip.antiAlias,
            child: user.imagePath != null
                ? Image.network(
                    user.userImage!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(placeholderPath),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AutoSizeText(
                      user.firstName != null && user.lastName != null
                          ? '${user.firstName} ${user.lastName} '
                          : '-',
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      )),
                  AutoSizeText('- ${user.industry ?? '-'}',
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              AutoSizeText('${user.numOfConnections} connections',
                  style: GoogleFonts.quicksand(
                    fontSize: 11,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          const Spacer(),
          AutoSizeText(rank.toString() + 'th',
              style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87)),

          // const Icon(
          //   Icons.arrow_upward,
          //   color: Colors.green,
          // )
        ],
      ),
    );
  }
}
