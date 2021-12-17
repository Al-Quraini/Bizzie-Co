import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/request/request_bloc.dart';
import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/initial_screen.dart';
import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/setting_list_item.dart';

class SettingPage extends StatefulWidget {
  static const String id = '/setting_page';
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Map<String, Widget> widgetMap = {};

  Widget? selectedList;
  String? heading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (selectedList != null) {
                          setState(() {
                            heading = null;
                            selectedList = null;
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                  Text(heading == null ? 'Settings' : heading!,
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            if (selectedList == null) defaultList() else selectedList!
          ],
        ),
      ),
    );
  }

  Widget defaultList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingListItem(
            title: 'Invite Friends',
            onPress: () {
              setState(() {
                heading = 'Invite Friends';
                selectedList = inviteFriends();
              });
            },
          ),
          const SettingListItem(
            title: 'Your Activity',
          ),
          SettingListItem(
              title: 'Notifications',
              onPress: () {
                setState(() {
                  heading = 'Notifications';
                  selectedList = notifications();
                });
              }),
          SettingListItem(
              title: 'Privacy',
              onPress: () {
                setState(() {
                  heading = 'Privacy';
                  selectedList = privacy();
                });
              }),
          SettingListItem(
              title: 'Security',
              onPress: () {
                setState(() {
                  heading = 'Security';
                  selectedList = security();
                });
              }),
          SettingListItem(
              title: 'Ads',
              onPress: () {
                setState(() {
                  heading = 'Ads';
                  selectedList = ads();
                });
              }),
          SettingListItem(
              title: 'Account',
              onPress: () {
                setState(() {
                  heading = 'Account';

                  selectedList = account();
                });
              }),
          SettingListItem(
              title: 'Help',
              onPress: () {
                setState(() {
                  heading = 'Help';

                  selectedList = help();
                });
              }),
          SettingListItem(
              title: 'About',
              onPress: () => setState(() {
                    heading = 'About';

                    selectedList = about();
                  })),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          SettingListItem(
            title: 'Log Out',
            color: Colors.red,
            onPress: logout,
          ),
        ],
      );

  Widget inviteFriends() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'Invite Friends By SMS',
          ),
          SettingListItem(
            title: 'Invite Friends By...',
          ),
        ],
      );

  Widget notifications() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'Post and Comments',
          ),
          SettingListItem(
            title: 'Connections',
          ),
          SettingListItem(
            title: 'From Bizzie',
          ),
          SettingListItem(
            title: 'Email and SMS',
          ),
        ],
      );

  Widget privacy() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'Comments',
          ),
          SettingListItem(
            title: 'Mentions',
          ),
          SettingListItem(
            title: 'Muted Accounts',
          ),
          SettingListItem(
            title: 'Reported Users',
          ),
        ],
      );

  Widget security() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'Password',
          ),
          SettingListItem(
            title: 'Login Activity',
          )
        ],
      );

  Widget ads() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'My Ads',
          ),
          SettingListItem(
            title: 'Ad History',
          ),
          SettingListItem(
            title: 'Place Ad',
          )
        ],
      );

  Widget account() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'Personal Information',
          ),
          SettingListItem(
            title: 'Language',
          )
        ],
      );

  Widget help() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'Report a Problem',
          ),
          SettingListItem(
            title: 'Help Center',
          )
        ],
      );

  Widget about() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SettingListItem(
            title: 'Data Policy',
          ),
          SettingListItem(
            title: 'Terms of Use',
          ),
          SettingListItem(
            title: 'Credits',
          )
        ],
      );

  Future<void> logout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Are you sure you want to log out ?",
        actionTitle: 'Log Out',
        onPress: logoutUser,
      ),
    );
  }

  Future<void> logoutUser() async {
    await AuthenticationService().userSignOut();
    if (!AuthenticationService().isSignedIn()) {
      Navigator.pushNamedAndRemoveUntil(
          context, InitialPage.id, ModalRoute.withName(InitialPage.id));

      BlocProvider.of<ConnectionsBloc>(context).add(ResetConnections());
      BlocProvider.of<RequestBloc>(context).add(CancelRequest());
      BlocProvider.of<ActivityBloc>(context).add(CancelActivity());

      FirestoreService.resetUser();
    }
  }
}
