import 'package:bizzie_co/presentation/screens/notification/notifications_tab.dart';
import 'package:bizzie_co/presentation/screens/notification/requests_tab.dart';
import 'package:bizzie_co/presentation/widgets/custom_tabbar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedTab = 0;
  List<Widget> tabs = const [NotificationTab(), RequestTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          CustomTabBar(
              stringValues: const [
                'Notifications',
                'Requests'
              ],
              iconValues: const [
                FontAwesomeIcons.bell,
                FontAwesomeIcons.userFriends
              ],
              onToggleCallback: (index) {
                setState(() {
                  _selectedTab = index;
                });
              }),
          tabs[_selectedTab]
        ],
      ),
    );
  }
}
