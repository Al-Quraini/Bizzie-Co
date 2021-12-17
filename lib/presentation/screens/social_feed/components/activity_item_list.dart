import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/like.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/home/profile_page.dart';
import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityItemList extends StatelessWidget {
  const ActivityItemList(
      {Key? key,
      required this.activity,
      required this.user,
      this.isMyActivity = false})
      : super(key: key);

  final Activity activity;
  final User user;
  final bool isMyActivity;

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
      child: Row(
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
                        )) */
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Newbee',
                    style: GoogleFonts.quicksand(
                        fontSize: 10, color: Colors.black54))
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
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
                      AutoSizeText('- ${user.occupation ?? '-'}',
                          style: GoogleFonts.quicksand(
                            fontSize: 11,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: activity.description,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              )),
                          TextSpan(
                              text:
                                  '\r\r\r${activity.timeStamp.hour}:${activity.timeStamp.minute}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.black54,
                                fontWeight: FontWeight.w300,
                              )),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                if (!isMyActivity)
                  IconButton(
                    splashColor: (Colors.transparent),
                    highlightColor: (Colors.transparent),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    focusColor: Colors.transparent,
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    icon: Icon(
                      FontAwesomeIcons.ellipsisV,
                      color: Colors.grey[500],
                      size: 15,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirestoreService()
                        .likesStream(activityId: activity.activityUid),
                    builder: (context, snapshot) {
                      List<Like> likes = [];
                      List<String> likeIds = [];
                      if (snapshot.hasData) {
                        likes = FirestoreService().getLikes(snapshot);
                        likeIds = likes.map((like) => like.likeDocId).toList();
                      }

                      return Column(
                        children: [
                          IconButton(
                            splashColor: (Colors.transparent),
                            highlightColor: (Colors.transparent),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            focusColor: Colors.transparent,
                            onPressed: () async {
                              final like = Like(
                                  likeDocId: FirestoreService.currentUser!.uid,
                                  timeStamp: DateTime.now());

                              FirestoreService()
                                  .likeActivity(activity.activityUid, like);
                            },
                            icon: Icon(
                              !likeIds.contains(
                                      FirestoreService.currentUser!.uid)
                                  ? FontAwesomeIcons.heart
                                  : FontAwesomeIcons.solidHeart,
                              color: primary,
                              size: 15,
                            ),
                          ),
                          if (likes.isNotEmpty) Text('${likes.length}')
                        ],
                      );
                    }),
              ],
            ),
          ))
        ],
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    // height: MediaQuery.of(context).size.height * 0.3,
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 1,
                          width: 80,
                          color: primary,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SheetItemList(
                          title: 'Report User',
                          color: Colors.red,
                          onPress: () {
                            Navigator.pop(context);

                            showReportBottomSheet(context);
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'View Profile',
                          onPress: () async {
                            Navigator.pop(context);
                            final card = await FirestoreService().getCardData(
                                userUid: user.uid, cardUid: user.primaryCard!);
                            Navigator.pushNamed(context, ProfilePage.id,
                                arguments: {
                                  'user': user,
                                  'card': card,
                                });
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Mute',
                          onPress: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const CustomDialog(
                                title: "Mute Jessica Jones?",
                                actionTitle: 'Mute',
                                description:
                                    'You will no longer see their posts. Bizzie won’t let them know you muted them.',
                              ),
                            );
                          },
                        ),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.fromLTRB(20, 0, 20,
                        MediaQuery.of(context).viewInsets.bottom + 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: SheetItemList(
                      title: 'Cancel',
                      onPress: () {
                        Navigator.pop(context);
                      },
                    )),
              ],
            ));
  }

  void showReportBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    // height: MediaQuery.of(context).size.height * 0.3,
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 1,
                          width: 80,
                          color: primary,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SheetItemList(
                          title: 'Report User',
                          description: 'Why are you reporting this user?',
                          onPress: () {
                            submitReport(context);
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Spam',
                          onPress: () {
                            submitReport(context);
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Bullying or harassment',
                          onPress: () {
                            submitReport(context);
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'False information',
                          onPress: () {
                            submitReport(context);
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Scam or fraud',
                          onPress: () {
                            submitReport(context);
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.fromLTRB(20, 0, 20,
                        MediaQuery.of(context).viewInsets.bottom + 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: SheetItemList(
                      title: 'Cancel',
                      onPress: () {
                        Navigator.pop(context);
                      },
                    )),
              ],
            ));
  }

  void submitReport(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) => const CustomDialog(
        done: true,
        title: "Thank you for letting us know",
        description:
            'Your feedback is important in helping us keep the Bizzie community safe.',
        dismissTitle: 'Close',
      ),
    );
  }
}
