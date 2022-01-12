import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/report.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/home/profile_page.dart';
import 'package:bizzie_co/presentation/screens/social_feed/activity_detail_page.dart';
import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityItemList extends StatefulWidget {
  const ActivityItemList(
      {Key? key, required this.activity, this.isMyActivity = false})
      : super(key: key);

  final Activity activity;
  final bool isMyActivity;

  @override
  State<ActivityItemList> createState() => _ActivityItemListState();
}

class _ActivityItemListState extends State<ActivityItemList> {
  late bool isLiked;
  late int numOfLikes;

  @override
  void initState() {
    super.initState();
    isLiked =
        widget.activity.likedBy.contains(FirestoreService.currentUser!.uid);

    numOfLikes = widget.activity.likedBy.length;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ActivityDetailPage(activity: widget.activity))),
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            border: widget.activity.isSponsored
                ? Border.all(color: primary, width: 2)
                : null,
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
                        child: widget.activity.userImagePath != null
                            ? Image.network(
                                widget.activity.userImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(placeholderPath),
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
                  if (widget.activity.isSponsored)
                    Text('Sponsored AD',
                        style: GoogleFonts.quicksand(
                            fontSize: 10,
                            color: primary,
                            fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${widget.activity.userFirstName} ${widget.activity.userLastName} ',
                                style: GoogleFonts.quicksand(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: '- ${widget.activity.industry ?? '-'}',
                                style: GoogleFonts.quicksand(
                                  fontSize: 11,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                )),
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.activity.url != null)
                      AspectRatio(
                        aspectRatio: 9 / 5,
                        child: Image.network(
                          widget.activity.photoUrl!,
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      )
                    else if (widget.activity.description != null)
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.activity.description!
                                          .replaceAll('\\n', "\n") +
                                      ' ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  )),
                              if (widget.activity.recieverUser != null)
                                TextSpan(
                                    text: widget.activity.recieverUser ==
                                            FirestoreService.currentUser!.uid
                                        ? 'you'
                                        : 'others',
                                    style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline)),
                              TextSpan(
                                  text:
                                      '\r\r\r${widget.activity.timestamp.toTimeAgo()}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ]),
                      ),
                    /* if (widget.activity.isSponsored)
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              FontAwesomeIcons.commentAlt,
                              color: primary,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // likeButton(isVertical: false, context: context),
                          ],
                        ),
                      ) */
                  ],
                ),
              ),
            ),
            if (!widget.activity.isSponsored)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:
                    /* const Icon(
                  FontAwesomeIcons.ban,
                  size: 17,
                  color: Colors.black38,
                ) */
                    Column(
                  children: [
                    if (!widget.isMyActivity)
                      IconButton(
                        splashColor: (Colors.transparent),
                        highlightColor: (Colors.transparent),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        focusColor: Colors.transparent,
                        onPressed: () {
                          showBottomSheet(context: context);
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
                    // likeButton(context: context),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  /* Widget likeButton({bool isVertical = true, required BuildContext context}) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              splashColor: (Colors.transparent),
              highlightColor: (Colors.transparent),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              focusColor: Colors.transparent,
              onPressed: () async {
                setState(() {
                  isLiked = !isLiked;

                  isLiked ? numOfLikes++ : numOfLikes--;
                });
                final like = Like(
                  industry: widget.activity.industry,
                  timestamp: DateTime.now(),
                  userFirstName: widget.activity.userFirstName,
                  userLastName: widget.activity.userLastName,
                  userImageUrl: widget.activity.userImageUrl,
                  likeDocId: FirestoreService.currentUser!.uid,
                );

                FirestoreService()
                    .likeActivity(widget.activity.activityUid, like);

                // final actiivityBloc = BlocProvider.of<ActivityBloc>(context)
                //     .state as ActivityLoaded;
              },
              icon: Icon(
                !isLiked ? FontAwesomeIcons.heart : FontAwesomeIcons.solidHeart,
                color: primary,
                size: 15,
              ),
            ),
            if (numOfLikes > 0 && !isVertical) Text('$numOfLikes')
          ],
        ),
        if (numOfLikes > 0 && isVertical) Text('$numOfLikes')
      ],
    );
  }
 */
  /* StreamBuilder<QuerySnapshot<Object?>> likeButton({bool isVertical = true}) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirestoreService().likesStream(activityId: activity.activityUid),
        builder: (context, snapshot) {
          List<Like> likes = [];
          List<String> likeIds = [];
          if (snapshot.hasData) {
            likes = FirestoreService().getLikes(snapshot);
            likeIds = likes.map((like) => like.likeDocId).toList();
          }

          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                    splashColor: (Colors.transparent),
                    highlightColor: (Colors.transparent),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    focusColor: Colors.transparent,
                    onPressed: () async {
                      final like = Like(
                        industry: activity.industry,
                        timestamp: DateTime.now(),
                        userFirstName: activity.userFirstName,
                        userLastName: activity.userLastName,
                        userImageUrl: activity.userImageUrl,
                        likeDocId: FirestoreService.currentUser!.uid,
                      );

                      FirestoreService()
                          .likeActivity(activity.activityUid, like);
                    },
                    icon: Icon(
                      !likeIds.contains(FirestoreService.currentUser!.uid)
                          ? FontAwesomeIcons.heart
                          : FontAwesomeIcons.solidHeart,
                      color: primary,
                      size: 15,
                    ),
                  ),
                  if (likes.isNotEmpty && !isVertical) Text('${likes.length}')
                ],
              ),
              if (likes.isNotEmpty && isVertical) Text('${likes.length}')
            ],
          );
        });
  }
 */
  void showBottomSheet({required BuildContext context}) {
    final rootNavigatorContext =
        Navigator.of(context, rootNavigator: true).context;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: rootNavigatorContext,
        isScrollControlled: true,
        builder: (_) => Column(
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
                            Navigator.pop(rootNavigatorContext);

                            showReportBottomSheet(rootNavigatorContext);
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
                            Navigator.pop(rootNavigatorContext);

                            final user = await FirestoreService().loadUserData(
                                userUid: widget.activity.activityUser);
                            final card = await FirestoreService().getCardData(
                                userUid: user!.uid, cardUid: user.primaryCard!);

                            final cards = await FirestoreService()
                                .getAllCards(userUid: user.uid);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProfilePage(
                                          user: user,
                                          card: card!,
                                          isMyProfile: false,
                                          cards: cards,
                                        )));
                          },
                        ),

                        // TODO : muting connection
                        /* const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Mute',
                          onPress: () {
                            Navigator.pop(rootNavigatorContext);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const CustomDialog(
                                color: Color(0xFF4BD37B),
                                title: "Mute Jessica Jones?",
                                actionTitle: 'Mute',
                                description:
                                    'You will no longer see their posts. Bizzie won’t let them know you muted them.',
                              ),
                            );
                          },
                        ), */
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
                        const SheetItemList(
                          title: 'Report User',
                          description: 'Why are you reporting this user?',
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Spam',
                          onPress: () async {
                            bool reportSuccess = await reportUser('spam');

                            Navigator.pop(context);
                            if (reportSuccess) {
                              submitReport(context);
                            }
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Bullying or harassment',
                          onPress: () async {
                            bool reportSuccess =
                                await reportUser('bullying or harassment');
                            Navigator.pop(context);

                            if (reportSuccess) {
                              submitReport(context);
                            }
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'False information',
                          onPress: () async {
                            bool reportSuccess =
                                await reportUser('false information');
                            Navigator.pop(context);

                            if (reportSuccess) {
                              submitReport(context);
                            }
                          },
                        ),
                        const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Scam or fraud',
                          onPress: () async {
                            bool reportSuccess =
                                await reportUser('scam or fraud');
                            Navigator.pop(context);

                            if (reportSuccess) {
                              submitReport(context);
                            }
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

  Future<bool> reportUser(String description) async {
    final Report report = Report(
        reportedUser: widget.activity.activityUser,
        reportUid: widget.activity.activityUid + widget.activity.activityUser,
        reportedBy: FirestoreService.currentUser!.uid,
        description: description,
        timestamp: DateTime.now());

    return await FirestoreService().addReport(report: report);
  }

  void submitReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const CustomDialog(
        done: true,
        color: Color(0xFF4BD37B),
        title: "Thank you for letting us know",
        description:
            'Your feedback is important in helping us keep the Bizzie community safe.',
        dismissTitle: 'Close',
      ),
    );
  }

  BuildContext getParentContext(BuildContext context) {
    return context.findAncestorStateOfType()!.context;
  }
}
