import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/presentation/screens/wallet/components/card_item.dart';

import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItemList extends StatelessWidget {
  const CardItemList({Key? key, required this.connection, required this.user})
      : super(key: key);

  final Connection connection;
  final User user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0)
          .copyWith(top: 10, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFEFF0F0),
          // border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              // profile image
              Container(
                height: 65,
                width: 65,
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  user.imageUrl ??
                      'https://www.gravatar.com/avatar/aaa832abcbd3c9f68fdce691a44dac7f?s=64&d=identicon&r=PG&f=1',
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),

              // icon
              /* const Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_box,
                    color: primary,
                  )
                  ) */
            ],
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      user.firstName != null && user.lastName != null
                          ? '${user.firstName} ${user.lastName} '
                          : '-',
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(user.occupation ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  Text('Chewy.com',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
          ),
          const CardItem()
        ],
      ),
    );
  }
}
