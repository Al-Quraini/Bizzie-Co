import 'dart:developer';

import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/request/request_bloc.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/home/qr_code_scanner.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/presentation/screens/notification/notification_page.dart';
import 'package:bizzie_co/presentation/screens/profile/profile_tab.dart';
import 'package:bizzie_co/presentation/screens/social_feed/social_feed.dart';
import 'package:bizzie_co/presentation/screens/wallet/cards_page.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/fab_bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  late User user;

  final _pages = [
    const SocialFeed(),
    const NotificationPage(),
    const CardsPage(),
    const ProfileTab()
  ];

  void _selectedTab(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    user = FirestoreService.currentUser!;

    BlocProvider.of<ConnectionsBloc>(context).add(LoadConnections());
    BlocProvider.of<RequestBloc>(context).add(LoadRequest());
    BlocProvider.of<ActivityBloc>(context).add(LoadActivity());
    BlocProvider.of<NotificationBloc>(context).add(LoadNotification());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _selectedTab,
        items: const [
          FABBottomAppBarItem(iconData: FontAwesomeIcons.rss, text: 'Feed'),
          FABBottomAppBarItem(
              iconData: Icons.notifications_none_outlined,
              text: 'Notifications'),
          FABBottomAppBarItem(
              iconData: FontAwesomeIcons.creditCard, text: 'Cards'),
          FABBottomAppBarItem(iconData: Icons.person_outline, text: 'Profile'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            onPressed: showBottomSheet,
            elevation: 2,
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
                  title: 'Share My Card',
                  onPress: showQRCode,
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
                    Text('Share My Card',
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
                  data: user.uid,
                  version: QrVersions.auto,
                  size: MediaQuery.of(context).size.width / 1.8,
                  gapless: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(user.occupation ?? '-',
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
            )));
  }

  // open scanner method
  void openScanner() async {
    Navigator.pop(context);
    final userUid =
        await Navigator.pushNamed(context, QRCodeScanner.id) as String;

    final newUser = await FirestoreService().loadUserData(userUid: userUid);

    if (newUser != null) {
      addToConnectionDialog(newUser);
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
                    child: newUser.imageUrl == null
                        ? const SizedBox()
                        : Image.network(
                            newUser.imageUrl!,
                            fit: BoxFit.fitHeight,
                          ),
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
                      Text(newUser.occupation ?? '-',
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
                              : '${newUser.location?.city}, ${getStateAbriviation()}',
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
                        requestFrom: user.uid,
                        requestTo: newUser.uid,
                        dateTime: DateTime.now(),
                        isPending: true);

                    final message =
                        await FirestoreService().addRequest(request: request);

                    if (message != null) {}
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

  // get the abriviation of the state
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

/**/ 