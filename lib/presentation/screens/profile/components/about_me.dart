import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              /*  const Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_box,
                    color: primary,
                    size: 15,
                  )) */
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: width / 2.7,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                      user.firstName != null && user.lastName != null
                          ? '${user.firstName} ${user.lastName}'
                          : '-',
                      maxLines: 1,
                      minFontSize: 8,
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
                  Text(
                      '${user.location?.city ?? ''}, ${getStateAbriviation() ?? ''}',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: lightOrang, fixedSize: const Size(120, 40)),
            onPressed: () {
              showDetailBottomSheet(context);
            },
            child: Text('Contact Me',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
          )
        ],
      ),
    );
  }

  // user detail bottom sheet
  void showDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: EdgeInsets.only(
                top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: 100,
                        color: primary,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 85,
                        width: 85,
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
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                                user.firstName != null && user.lastName != null
                                    ? '${user.firstName} ${user.lastName}'
                                    : '-',
                                maxLines: 1,
                                minFontSize: 8,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: lightOrang,
                                    fixedSize: const Size(120, 30)),
                                onPressed: () {
                                  // showDetailBottomSheet(context);
                                },
                                child: AutoSizeText('Download Contact',
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // phone field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Phone',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text('123456789',
                            style: GoogleFonts.poppins(
                              letterSpacing: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('mobile',
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54)),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Text('123456789',
                            style: GoogleFonts.poppins(
                              letterSpacing: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('work',
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54)),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    height: 5,
                    indent: 20,
                    endIndent: 20,
                  ),

                  // email field
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text('Email',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('m@gmail.com',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    height: 5,
                    indent: 20,
                    endIndent: 20,
                  ),

                  // website field
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text('Website',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('https://www.google.com',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    height: 5,
                    indent: 20,
                    endIndent: 20,
                  ),

                  // address field
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text('Address',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('1234 Main st\nBostom MA 1234',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    height: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
            )));
  }

  String? getStateAbriviation() {
    if (user.location == null || user.location!.state!.isEmpty) return null;
    String state = user.location?.state ?? '';
    List<String> splitted = state.split('');
    String abriviation = state.substring(0, 2).toUpperCase();

    if (splitted.length == 2) {
      abriviation =
          '${splitted[0].substring(0, 1)}${splitted[1].substring(0, 1)}';
      return abriviation.toUpperCase();
    }

    return abriviation;
  }
}
