import 'package:bizzie_co/presentation/screens/notification/notifications_tab.dart';
import 'package:bizzie_co/presentation/screens/notification/requests_tab.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: primary,
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Notifications',
              ),
              Tab(text: 'Requests'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [NotificationTab(), RequestTab()],
        ),
      ),
    );
  }
}
