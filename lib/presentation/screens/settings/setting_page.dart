import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/request/request_bloc.dart';
import 'package:bizzie_co/business_logic/cubit/comments/comments_cubit.dart';
import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/initial_screen.dart';
import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/help.dart';
import 'components/invite_friends.dart';
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
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (selectedList == null) defaultList() else selectedList!,
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
                selectedList = const InviteFriends();
              });
            },
          ),
          // TODO : Notifications
          /* SettingListItem(
              title: 'Notifications',
              onPress: () {
                setState(() {
                  heading = 'Notifications';
                  selectedList = const NotificationSetting();
                });
              }), */

          // TODO : Privacy
          /* SettingListItem(
              title: 'Privacy',
              onPress: () {
                setState(() {
                  heading = 'Privacy';
                  selectedList = const Privacy();
                });
              }), */

          // TODO : change password

          /* SettingListItem(
              title: 'Password',
              onPress: () {
                setState(() {
                  heading = 'Password';
                  selectedList = const ChangePassword();
                });
              }), */
          // SettingListItem(
          //     title: 'Ads',
          //     onPress: () {
          //       setState(() {
          //         heading = 'Ads';
          //         selectedList = const Ads();
          //       });
          //     }),
          // SettingListItem(
          //     title: 'Account',
          //     onPress: () {
          //       setState(() {
          //         heading = 'Account';

          //         selectedList = const Account();
          //       });
          //     }),
          SettingListItem(
              title: 'Help',
              onPress: () {
                setState(() {
                  heading = 'Help';

                  selectedList = const Help();
                });
              }),
          // SettingListItem(
          //     title: 'About',
          //     onPress: () => setState(() {
          //           heading = 'About';

          //           selectedList = const About();
          //         })),
          const SizedBox(
            height: 30,
          ),
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

  // Widget inviteFriends() => InviteFriends();

  // Widget notifications() => Notifications();

  // Widget privacy() => Privacy();

  // Widget security() => Security();

  // Widget ads() => Ads();

  // Widget account() => Account();

  // Widget help() => Help();

  // Widget about() => About();

  Future<void> logout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        color: const Color(0xFF4BD37B),
        title: "Are you sure you want to log out ?",
        actionTitle: 'Log Out',
        onPress: logoutUser,
      ),
    );
  }

  Future<void> logoutUser() async {
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    BlocProvider.of<ConnectionsBloc>(rootNavigator.context)
        .add(ResetConnections());
    BlocProvider.of<RequestBloc>(rootNavigator.context).add(CancelRequest());
    BlocProvider.of<ActivityBloc>(rootNavigator.context).add(CancelActivity());
    BlocProvider.of<LeaderboardBloc>(rootNavigator.context)
        .add(CancelLeaderboard());
    BlocProvider.of<CommentsCubit>(context).emitCommentsInitial();
    await AuthenticationService().userSignOut();
    if (!AuthenticationService().isSignedIn()) {
      // Navigator.pop(context);
      Navigator.of(rootNavigator.context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const InitialPage()),
          ModalRoute.withName(InitialPage.id));

      FirestoreService.resetUser();
    }
  }
}
