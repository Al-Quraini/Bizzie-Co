import 'dart:developer';
import 'package:bizzie_co/business_logic/bloc/Event/events_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/my_activity/my_activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/request/request_bloc.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/ticket.dart';
import 'package:intl/intl.dart';
import 'package:bizzie_co/utils/extension.dart';

import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/presentation/screens/events/events_page.dart';
import 'package:bizzie_co/presentation/screens/home/qr_code_scanner.dart';
import 'package:bizzie_co/presentation/screens/profile/profile_tab.dart';
import 'package:bizzie_co/presentation/screens/social_feed/social_feed.dart';
import 'package:bizzie_co/presentation/screens/wallet/cards_page.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/fab_bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  late List<Ticket> tickets;

  // current page string
  String currentPageString = "";
  // current page index
  int _currentPageIndex = 0;
  // pages

  // global keys
  final _socialFeed = GlobalKey<NavigatorState>();
  final _events = GlobalKey<NavigatorState>();

  final _cardsPage = GlobalKey<NavigatorState>();
  final _profilePage = GlobalKey<NavigatorState>();

  // invoke this method when selecting tab
  void _selectedTab(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    tickets = FirestoreService.tickets ?? [];
    user = FirestoreService.currentUser!;
    BlocProvider.of<ConnectionsBloc>(context).add(LoadConnections());
    BlocProvider.of<ActivityBloc>(context).add(LoadActivity());
    BlocProvider.of<MyActivityBloc>(context).add(LoadMyActivity());
    BlocProvider.of<RequestBloc>(context).add(LoadRequest());
    BlocProvider.of<LeaderboardBloc>(context).add(LoadLeaderboard());
    BlocProvider.of<NotificationBloc>(context).add(LoadNotification());
    BlocProvider.of<EventBloc>(context).add(LoadEvents());
    // BlocProvider.of<UserCubit>(context).emitUser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          Navigator(
            key: _events,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => EventsPage(
                user: user,
              ),
            ),
          ),
          Navigator(
            key: _socialFeed,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (_) => SocialFeed(
                parentContext: context,
              ),
            ),
          ),
          Navigator(
            key: _cardsPage,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const CardsPage(),
            ),
          ),
          Navigator(
            key: _profilePage,
            onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => const ProfileTab(
                      isMyProfile: true,
                    )),
          ),
        ],
      ),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _selectedTab,
        items: const [
          FABBottomAppBarItem(
              iconData: Icons.calendar_today_outlined, text: 'Events'),
          /* FABBottomAppBarItem(
              iconData: Icons.notifications_none_outlined,
              text: 'Notifications'), */
          FABBottomAppBarItem(iconData: FontAwesomeIcons.rss, text: 'Feed'),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.idCard, text: 'Cards'),
          FABBottomAppBarItem(iconData: Icons.person_outline, text: 'Profile'),
        ],
      ),

      /* -------------------------------------------------------------------------- */
      /*                         ADD Floating action button                         */
      /* -------------------------------------------------------------------------- */
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: Align(
          alignment: const Alignment(0, 1),
          child: SizedBox(
            width: 80,
            height: 80,
            child: FloatingActionButton(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightElevation: 1,
              onPressed: showBottomSheet,
              elevation: 0,
              backgroundColor: Colors.white,
              child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: authButtonGredient,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 50,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int val, BuildContext context) {
    if (_currentPageIndex == val) {
      switch (val) {
        case 0:
          _socialFeed.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _events.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          _cardsPage.currentState!.popUntil((route) => route.isFirst);
          break;
        case 3:
          _profilePage.currentState!.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentPageIndex = val;
        });
      }
    }
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
                bottom: MediaQuery.of(context).viewInsets.bottom + 100),
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
                  title: 'Show QR Code',
                  onPress: showQRCode,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                SheetItemList(
                  title: 'Share My Card',
                  onPress: () {
                    Navigator.pop(context);
                    Share.share(
                      'check out my website https://example.com',
                    );
                  },
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                SheetItemList(
                  title: 'Scan QR Code',
                  onPress: openScanner,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                SheetItemList(
                  title: 'Tickets',
                  onPress: showTicketsBottomSheet,
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            )));
  }

  // display bottom sheet qr code
  void showQRCode() {
    Navigator.pop(context);
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 100),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 2,
                    width: 100,
                    color: primary,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Share My Profile',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 20,
                  ),
                  QrImage(
                    data: user.uid,
                    version: QrVersions.auto,
                    size: MediaQuery.of(context).size.width / 1.8,
                    gapless: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(user.industry ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      user.firstName != null && user.lastName != null
                          ? '${user.firstName} ${user.lastName}'
                          : '-',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            )));
  }

  // open scanner method
  void openScanner() async {
    Navigator.pop(context);
    final userUid =
        await Navigator.pushNamed(context, QRCodeScanner.id) as String?;
    if (userUid != null) {
      final newUser = await FirestoreService().loadUserData(userUid: userUid);
      if (newUser != null) {
        addToConnectionDialog(newUser);
      }
    }
  }

// Add Connection Dialog
  void addToConnectionDialog(User newUser) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add New Connection'),
              content: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 70,
                    width: 70,
                    child: newUser.imagePath == null
                        ? const SizedBox()
                        : FutureBuilder<String?>(
                            future:
                                StorageService().getImageUrl(newUser.imagePath),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.fitHeight,
                                );
                              }
                              return const SizedBox();
                            }),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          newUser.firstName != null && newUser.lastName != null
                              ? '${newUser.firstName} ${newUser.lastName}'
                              : '-',
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(newUser.industry ?? '-',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                          newUser.location == null
                              ? '-'
                              : '${newUser.location?.city ?? ''}, ${newUser.location?.state ?? ''}',
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    final Request request = Request(
                        userFirstName: user.firstName!,
                        userLastName: user.lastName!,
                        userImagePath: user.imagePath,
                        industry: user.industry,
                        requestFrom: user.uid,
                        requestTo: newUser.uid,
                        timestamp: DateTime.now(),
                        isPending: true);

                    final message =
                        await FirestoreService().addRequest(request: request);

                    if (message != null) {
                      log(message);
                    }
                  },
                  child: const Text(
                    'Add',
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ));
  }

  /* -------------------------------------------------------------------------- */
  /*                                 my tickets                                 */
  /* -------------------------------------------------------------------------- */
  void showTicketsBottomSheet() {
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
                Text('My Tickets',
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
                        title: tickets[index].eventTitle,
                        onPress: () {
                          Navigator.pop(context);
                          showTicketQRCode(tickets[index]);
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
                    itemCount: tickets.length),
              ],
            )));
  }

  // show ticket QR code
  void showTicketQRCode(Ticket ticket) {
    final endTime = ticket.eventTime
        .copyWith(hour: ticket.eventTime.hour + ticket.eventDuration);

    Navigator.pop(context);
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.only(
                top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 2,
                    width: 100,
                    color: primary,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('My Ticket',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.keyboard_arrow_down_sharp)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  QrImage(
                    data: ticket.eventUid,
                    version: QrVersions.auto,
                    size: MediaQuery.of(context).size.width / 1.8,
                    gapless: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(ticket.eventTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('1 X Ticket',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(ticket.eventVenue,
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.calendar,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(DateFormat("MMMM dd, yyyy").format(ticket.eventTime),
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        FontAwesomeIcons.clock,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                          '${DateFormat("hh:mm aa").format(ticket.eventTime)} - ${DateFormat("hh:mm aa").format(endTime)}',
                          style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
