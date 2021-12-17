import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/profile/setting_page.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';

import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'card/add_new_card_page.dart';
import 'components/about_me.dart';
import 'components/profile_card.dart';
import 'components/stats_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key, this.user, this.card}) : super(key: key);

  final User? user;
  final UserCard? card;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final iconKey = GlobalKey();
  late User currentUser;
  late UserCard card;

  @override
  void initState() {
    super.initState();

    currentUser = widget.user ?? FirestoreService.currentUser!;
    card = widget.card ?? FirestoreService.primaryCard!;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   width: iconKey.currentContext?.size?.width ?? 0,
                // ),
                if (widget.user != null)
                  SizedBox(
                    width: 45,
                    child: InkWell(
                      // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: const Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                else
                  const SizedBox(
                    width: 45,
                  ),

                InkWell(
                  onTap: showBottomSheet,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  highlightColor: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(currentUser.occupation ?? '-',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w400)),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
                if (widget.user == null)
                  SizedBox(
                    width: 45,
                    child: InkWell(
                        key: iconKey,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.pushNamed(context, SettingPage.id);
                        },
                        child: const Icon(Icons.settings_outlined, size: 28)),
                  )
                else
                  const SizedBox(
                    width: 45,
                  ),
              ],
            ),
          )),
          ProfileCard(
            card: card,
            isCurrentUser: widget.user == null,
          ),
          AboutMe(
            user: currentUser,
          ),
          const SizedBox(
            height: 15,
          ),
          StatsField(
            width: width,
            user: currentUser,
          ),
          const Divider(
            height: 50,
            indent: 20,
            endIndent: 20,
          ),

          // About me
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('About Me',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(
                'Lorem ipsum dolor sit amet consectetur adipiscing elit tempor facilisis faucibus vehicula, platea urna placerat bibendum dictumst gravida pellentesque aliquet molestie torquent. Lacus nisi facilisi condimentum netus elementum dignissim accumsan interdum lectus est vivamus sem rhoncus, purus quis fusce mauris luctus pretium nisl parturient at',
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.normal)),
          ),
          // Education

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Education',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Boston University',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(' - B.S. Real Estate',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Text('2005 - 2009\nBoston, Massachusetts, United States',
                    style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w300)),
                Text(
                    'orem ipsum dolor sit amet consectetur adipiscing elit tempor facilisis faucibus vehicula, platea urna placerat bibendum dictumst',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.normal)),
              ],
            ),
          ),

          // Experience
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Experience',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Realtor',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(' - AI Real Estate',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Text('2005 - 2009\nBoston, Massachusetts, United States',
                    style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w300)),
                Text(
                    'orem ipsum dolor sit amet consectetur adipiscing elit tempor facilisis faucibus vehicula, platea urna placerat bibendum dictumst',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.normal)),
              ],
            ),
          ),

          // Skills
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Skills',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(
                'orem ipsum dolor sit amet \nconsectetur adipiscing \nelit tempor facilisis faucibus \nvehicula, platea urna placerat \nbibendum dictumst',
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.normal)),
          ),

// Interests
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Interests',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(
                'orem ipsum dolor sit amet \nconsectetur adipiscing \nelit tempor facilisis faucibus \nvehicula, platea urna placerat \nbibendum dictumst',
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
            // height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 200),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 100,
                  color: primary,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('My Cards',
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                const SheetItemList(
                  title: 'Share My Card',
                  // onPress: showQRCode,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                const SheetItemList(
                  title: 'Scan Card',
                  // onPress: openScanner,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                if (widget.user == null)
                  SheetItemList(
                    title: '+ Add New Card',
                    // onPress: showQRCode,
                    onPress: () {
                      Navigator.pop(context);
                      return Navigator.pushNamed(context, AddNewCardPage.id);
                    },
                  ),
              ],
            )));
  }
}
