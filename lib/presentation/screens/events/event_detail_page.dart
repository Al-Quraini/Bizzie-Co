import 'package:bizzie_co/business_logic/cubit/attendees/attendees_cubit.dart';
import 'package:bizzie_co/data/models/attendee.dart';
import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/models/report.dart';
import 'package:bizzie_co/data/models/ticket.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/events/event_tabs/attendees_tab.dart';
import 'package:bizzie_co/presentation/screens/events/event_tabs/sponsors_tab.dart';
import 'package:bizzie_co/presentation/widgets/animated_toggle.dart';
import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizzie_co/utils/extension.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_tabs/detail_tab.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  int _selectedTab = 0;

  late List<Widget> _tabs;

  late Event event;

  @override
  void initState() {
    super.initState();
    _tabs = [
      DetailTab(
        event: widget.event,
      ),
      const AttendeesTab(),
    ];
    event = widget.event;

    BlocProvider.of<AttendeesCubit>(context)
        .emitAttendeesLoading(event: widget.event);
  }

  @override
  Widget build(BuildContext context) {
    final endTime = event.time.copyWith(hour: event.time.hour + event.duration);

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: width * 0.85,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  image: DecorationImage(
                      image: NetworkImage(event.eventImageUrl!),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    // width: width,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                    // color: primary,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        // secondary,
                        Color(0xaa6535CB),
                        Color(0x00000fff),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 0.9],
                    )),
                    child: Row(
                      children: [
                        Text(
                          event.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const Spacer(),

                        /*  const Icon(
                          FontAwesomeIcons.bookmark,
                          color: Colors.white,
                          size: 25,
                        ), */
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () => showBottomSheet(context),
                          child: const Icon(
                            FontAwesomeIcons.ellipsisV,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(event.venue,
                              style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.calendar,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(DateFormat("MMMM dd, yyyy").format(event.time),
                              style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              '${DateFormat("hh:mm aa").format(event.time)} - ${DateFormat("hh:mm aa").format(endTime)}',
                              style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF371879)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                        fixedSize:
                            MaterialStateProperty.all(const Size(130, 40))),
                    onPressed: () async {
                      final ticket = Ticket(
                          eventUid: event.id,
                          userUid: FirestoreService.currentUser!.uid,
                          timeStamp: DateTime.now(),
                          eventTitle: event.title,
                          eventVenue: event.venue,
                          eventTime: event.time,
                          eventDuration: event.duration);

                      final attendee = Attendee(
                          firstName: FirestoreService.currentUser!.firstName!,
                          lastName: FirestoreService.currentUser!.lastName!,
                          userUid: FirestoreService.currentUser!.uid,
                          email: FirestoreService.currentUser!.email,
                          industry: FirestoreService.currentUser!.industry!,
                          imagePath: FirestoreService.currentUser!.imagePath,
                          timestamp: DateTime.now());

                      final message = await FirestoreService().attendEvent(
                        attendee: attendee,
                        ticket: ticket,
                        eventUid: event.id,
                        userUid: FirestoreService.currentUser!.uid,
                      );

                      if (message == null) {
                        eventAttending(context);
                      } else {
                        alreadyAttending(context, message);
                      }
                      // showDetailBottomSheet(context);
                    },
                    child: Text('Get Tickets',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  )
                ],
              ),
            ),
            Container(
              width: width,
              height: 85,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hosted By ',
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('${event.userFirstName} ${event.userLastName}',
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(event.userImage!),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: AnimatedToggle(
                  values: const ['Details', 'Attendees'],
                  onToggleCallback: (value) {
                    setState(() {
                      _selectedTab = value;
                    });
                  }),
            ),
            _tabs[_selectedTab]
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
                  title: 'Report',
                  color: Colors.red,
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
        reportedUser: widget.event.userUid,
        reportUid: widget.event.id + widget.event.userUid,
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
        description:
            'Your feedback is important in helping us keep the Bizzie community safe.',
        dismissTitle: 'Close',
        color: Color(0xFF4BD37B),
      ),
    );
  }

  void eventAttending(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const CustomDialog(
        done: true,
        title: "Successfully registered",
        description: 'When you come, show us the ticket.',
        dismissTitle: 'Close',
        color: Color(0xFF4BD37B),
      ),
    );
  }

  void alreadyAttending(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        done: true,
        title: "Registeration Error",
        color: Colors.red,
        description: message,
        icon: Icons.error_outline_rounded,
        dismissTitle: 'Close',
      ),
    );
  }
}
