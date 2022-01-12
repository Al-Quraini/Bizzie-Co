import 'package:bizzie_co/presentation/screens/social_feed/leaderboard_tabs/leader_connections_tab.dart';
import 'package:bizzie_co/presentation/screens/social_feed/leaderboard_tabs/world_wide_tab.dart';
import 'package:bizzie_co/presentation/widgets/custom_tabbar.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardTab extends StatefulWidget {
  // static const String id = '/leaderboard_tab';
  const LeaderboardTab({Key? key}) : super(key: key);

  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  // int _selectedTab = 0;
  // List<Widget> leaderTabs = const [
  //   WorldWideTab(),
  //   LeaderConnectinosTab(),
  // ];
  @override
  Widget build(BuildContext context) {
    // TODO : implent connection leader board
    return const WorldWideTab();
  }
}
