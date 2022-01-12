import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/models/report.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/events/event_detail_page.dart';
import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:bizzie_co/utils/extension.dart';

class EventItemList extends StatelessWidget {
  const EventItemList({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;
  @override
  Widget build(BuildContext context) {
    final endTime = event.time.copyWith(hour: event.time.hour + event.duration);
    String formattedDate =
        DateFormat("MMMM dd, yyyy  hh:mm aa").format(event.time);

    String formattedEndDate = DateFormat("hh:mm aa").format(endTime);
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => EventDetailPage(event: event))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: width,
        height: 120,
        decoration: const BoxDecoration(color: Color(0x44C4C4C4)),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                event.eventImageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        event.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Text(
                        '$formattedDate - $formattedEndDate',
                        // 'July 20th, 2022  2 PM - 8 PM',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(event.venue,
                              style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*  IconButton(
                      splashRadius: 20,
                      highlightColor: Colors.transparent,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.bookmark, size: 20)), */
                  IconButton(
                      splashRadius: 20,
                      constraints: const BoxConstraints(),
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showBottomSheet(context);
                      },
                      icon: const Icon(FontAwesomeIcons.ellipsisV, size: 20)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
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
                top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 75),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 100,
                  color: primary,
                ),
                const SizedBox(
                  height: 20,
                ),
                SheetItemList(
                  title: 'Report', color: Colors.red,
                  onPress: () {
                    Navigator.pop(rootNavigatorContext);
                    showReportBottomSheet(rootNavigatorContext);
                  },
                  // onPress: showQRCode,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                const SheetItemList(
                  title: 'Share',
                  // onPress: showQRCode,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            )));
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
                            bool reportSuccess = await reportEvent('spam');

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
                                await reportEvent('bullying or harassment');
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
                                await reportEvent('false information');
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
                                await reportEvent('scam or fraud');
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

  Future<bool> reportEvent(String description) async {
    final Report report = Report(
        reportedUser: event.userUid,
        reportUid: event.id + event.userUid,
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
        title: "Thank you for letting us know",
        color: Color(0xFF4BD37B),
        description:
            'Your feedback is important in helping us keep the Bizzie community safe.',
        dismissTitle: 'Close',
      ),
    );
  }
}
