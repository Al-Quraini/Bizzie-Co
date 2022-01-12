import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankItem extends StatelessWidget {
  const RankItem({
    Key? key,
    required this.user,
    required this.rank,
  }) : super(key: key);

  final User user;
  final Rank rank;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double dimension = width;
    Icon icon = const Icon(
      Icons.arrow_upward,
      color: Colors.green,
    );
    Color color = gold;
    String text = '1';
    if (rank == Rank.first) {
      color = gold;
      text = '1';
      dimension = width * 0.28;
    } else if (rank == Rank.second) {
      color = silver;
      text = '2';
      icon = const Icon(
        Icons.arrow_downward,
        color: Colors.red,
      );
      dimension = width * 0.23;
    } else {
      dimension = width * 0.19;
      color = bronze;
      text = '3';
    }
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              clipBehavior: Clip.hardEdge,
              height: dimension * 1.1,
              width: dimension * 1.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: user.imagePath != null
                      ? NetworkImage(
                          user.userImage!,
                        )
                      : placeholer,
                ),
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                child: LayoutBuilder(builder: (context, constraint) {
                  return Text(
                    text,
                    style: GoogleFonts.poppins(
                        fontSize: constraint.maxHeight * 0.7,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  );
                }),
                clipBehavior: Clip.hardEdge,
                height: dimension * 0.45,
                width: dimension * 0.45,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   width: 30,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: GoogleFonts.quicksand(
                      fontSize: dimension * 0.1,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                FittedBox(
                  child: Text(
                    user.industry ?? '',
                    style: GoogleFonts.quicksand(
                        fontSize: dimension * 0.1,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  '${user.numOfConnections} Connections',
                  style: GoogleFonts.quicksand(
                      fontSize: dimension * 0.1,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            // icon
          ],
        )
      ],
    );
  }
}
