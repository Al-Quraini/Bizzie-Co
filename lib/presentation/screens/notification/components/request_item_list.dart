import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';

import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestItemList extends StatelessWidget {
  const RequestItemList({Key? key, required this.request, required this.user})
      : super(key: key);

  final Request request;
  final User user;
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
                flex: 2,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // profile image
                        Container(
                          height: 70,
                          width: 70,
                          child: Image.network(
                            user.imageUrl ??
                                'https://www.gravatar.com/avatar/aaa832abcbd3c9f68fdce691a44dac7f?s=64&d=identicon&r=PG&f=1',
                            fit: BoxFit.cover,
                          ),
                          clipBehavior: Clip.antiAlias,
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
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    children: [
                      Row(
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
                          Text('- ${user.occupation ?? '-'}',
                              style: GoogleFonts.quicksand(
                                fontSize: 13,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'Shared their card with you. Would you like to share your card?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                  text: '\r\r\r7 hrs',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 30),
                                    elevation: 1,
                                    primary: toggleBtnBackground),
                                onPressed: () async {
                                  await FirestoreService()
                                      .denyRequest(request: request);
                                },
                                child: Text('Deny',
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: const Color(0xFF5C5C5C))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 30),
                                    elevation: 1,
                                    primary: primary),
                                onPressed: () async {
                                  await FirestoreService()
                                      .acceptRequest(request: request);
                                },
                                child: Text('Connect',
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: const Color(0xFFFFFFFF))),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.ellipsisV,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /* const Icon(
                          FontAwesomeIcons.heart,
                          color: primary,
                          size: 15,
                        ), */
                  ],
                ),
              ))
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

  Future<User?>? getUserData() async =>
      await FirestoreService().loadUserData(userUid: request.requestFrom);
}
