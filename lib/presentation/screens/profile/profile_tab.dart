import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/profile/card/card_detail_page.dart';
import 'package:bizzie_co/presentation/screens/profile/components/edit_education.dart';
import 'package:bizzie_co/presentation/screens/profile/components/edit_field_page.dart';
import 'package:bizzie_co/presentation/screens/settings/setting_page.dart';
import 'package:bizzie_co/presentation/widgets/promotion_dialog.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';

import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:uuid/uuid.dart';

import 'components/about_me.dart';
import 'components/edit_experience.dart';
import 'components/profile_card.dart';
import 'components/stats_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab(
      {Key? key, this.user, this.card, required this.isMyProfile, this.cards})
      : super(key: key);

  final User? user;
  final UserCard? card;
  final List<UserCard>? cards;
  final bool isMyProfile;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final iconKey = GlobalKey();
  late User currentUser;
  late UserCard card;
  late List<UserCard> cards;

  int selectedCard = 0;
  @override
  void initState() {
    super.initState();

    currentUser = widget.user ?? FirestoreService.currentUser!;
    card = widget.card ?? FirestoreService.primaryCard!;
    cards = widget.cards ?? FirestoreService.cards!;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: iconKey.currentContext?.size?.width ?? 0,
                // ),
                if (!widget.isMyProfile)
                  Container(
                    alignment: Alignment.centerLeft,
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
                  const Expanded(
                    child: SizedBox(
                      width: 45,
                    ),
                  ),

                // TODO : Later work on promotion
                /* else
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: primary, width: 2),
                            primary: Colors.white,
                            fixedSize: const Size(85, 35)),
                        onPressed: () {
                          // showDetailBottomSheet(context);
                          showPromotionDialog();
                        },
                        child: FittedBox(
                          child: Text('PROMOTE',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ), */
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: showBottomSheet,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      highlightColor: Colors.transparent,
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(currentUser.industry ?? '-',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w400)),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.isMyProfile)
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          key: iconKey,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SettingPage()));
                          },
                          child: const Icon(Icons.settings_outlined, size: 28)),
                    ),
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
            isCurrentUser: widget.isMyProfile,
            update: (val) => setState(() {
              if (val != null) selectedCard = val;

              card = FirestoreService.primaryCard!;
            }),
          ),
          AboutMe(user: currentUser, card: cards[selectedCard]),
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
                if (widget.isMyProfile)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    highlightColor: Colors.transparent,
                    splashRadius: 20,
                    // splashColor: Colors.transparent,
                    onPressed: () async {
                      final bool? successfullyUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditFieldPage()));

                      if (successfullyUpdated is bool && successfullyUpdated) {
                        await FirestoreService().loadUserData(
                            userUid: FirestoreService.currentUser!.uid);

                        updateUserData();
                      }
                    },
                    icon: const Icon(
                      Icons.drive_file_rename_outline_outlined,
                      color: Colors.black,
                    ),
                  )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(currentUser.aboutMe ?? 'There is nothing yet...',
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
                if (widget.isMyProfile)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    highlightColor: Colors.transparent,
                    splashRadius: 20,
                    // splashColor: Colors.transparent,
                    onPressed: () async {
                      final bool successfullyUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditEducation()));

                      if (successfullyUpdated) {
                        await FirestoreService().loadUserData(
                            userUid: FirestoreService.currentUser!.uid);

                        updateUserData();
                      }
                    },
                    icon: const Icon(
                      Icons.drive_file_rename_outline_outlined,
                      color: Colors.black,
                    ),
                  )
              ],
            ),
          ),
          if (currentUser.education != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(currentUser.education?.institution ?? '',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(' - ${currentUser.education?.degree ?? ''}',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  if (currentUser.education?.startDate != null &&
                      currentUser.education?.endDate != null)
                    Text(
                        '${currentUser.education?.startDate?.year} - ${currentUser.education?.endDate?.year}',
                        // '\n${currentUser.education?.location?.city ?? ''}, ${currentUser.education?.location?.state ?? ''}, ${currentUser.education?.location?.country ?? ''}',
                        style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                  Text(currentUser.education?.description ?? '',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                ],
              ),
            )
          else
            const SizedBox(
              height: 15,
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
                if (widget.isMyProfile)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    highlightColor: Colors.transparent,
                    splashRadius: 20,
                    // splashColor: Colors.transparent,
                    onPressed: () async {
                      final bool successfullyUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditExperience()));

                      if (successfullyUpdated) {
                        await FirestoreService().loadUserData(
                            userUid: FirestoreService.currentUser!.uid);

                        updateUserData();
                      }
                    },
                    icon: const Icon(
                      Icons.drive_file_rename_outline_outlined,
                      color: Colors.black,
                    ),
                  )
              ],
            ),
          ),
          if (currentUser.experience != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(currentUser.experience!.profession ?? '',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(' - ${currentUser.experience!.field}',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  if (currentUser.experience?.startDate != null &&
                      currentUser.experience?.endDate != null)
                    Text(
                        '${currentUser.experience?.startDate?.year} - ${currentUser.experience?.endDate?.year}',
                        // '\n${currentUser.experience?.location?.city ?? ''}, ${currentUser.experience?.location?.state ?? ''}, ${currentUser.experience?.location?.country ?? ''}',
                        style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                  Text(currentUser.experience?.description ?? '',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                ],
              ),
            )
          else
            const SizedBox(
              height: 25,
            ),

          // TODO : skills and interests coming soon
          /*    // Skills
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Skills',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                if (widget.isMyProfile)
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
                if (widget.isMyProfile)
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
          ), */
        ],
      ),
    );
  }

  void updateUserData() {
    setState(() {
      currentUser = FirestoreService.currentUser!;
    });
  }

  // TODO : Later work on promotion
  // this method will show promotion dialog
  Future<void> showPromotionDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => PromotionDialog(
        rootContext: this.context,
      ),
    );
  }

  void showBottomSheet() {
    final rootNavigatorContext =
        Navigator.of(context, rootNavigator: true).context;

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: rootNavigatorContext,
        isScrollControlled: true,
        builder: (_) => Container(
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
                ListView.separated(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SheetItemList(
                        title: cards[index].position,
                        onPress: () {
                          setState(() {
                            card = cards[index];
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 5,
                        indent: 20,
                        endIndent: 20,
                      );
                    },
                    itemCount: cards.length),
                if (widget.isMyProfile)
                  const Divider(
                    height: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                if (widget.isMyProfile)
                  SheetItemList(
                    title: '+ Add New Card',
                    // onPress: showQRCode,
                    onPress: () {
                      Navigator.pop(rootNavigatorContext);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CardDetailPage(
                                    isInitialCard: false,
                                    cardUid: const Uuid().v4(),
                                  )));
                    },
                  ),
              ],
            )));
  }
}
