import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItemList extends StatelessWidget {
  const NotificationItemList(
      {Key? key, required this.user, required this.notification})
      : super(key: key);

  final User user;
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          // border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // profile image
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: 70,
                          width: 70,
                          child: user.imageUrl == null
                              ? const SizedBox()
                              : Image.network(
                                  user.imageUrl!,
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
                            )) */
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 8, 0),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: user.firstName != null &&
                                      user.lastName != null
                                  ? '${user.firstName} ${user.lastName} '
                                  : '-',
                              style: GoogleFonts.quicksand(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                              text: 'Liked your update',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              )),
                          TextSpan(
                              text:
                                  '\r\r\r${notification.timeStamp.hour}: ${notification.timeStamp.minute}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.black54,
                                fontWeight: FontWeight.w300,
                              )),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 25,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
