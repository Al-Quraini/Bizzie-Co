import 'package:bizzie_co/presentation/screens/social_feed/tabs/connections_tab.dart';
import 'package:bizzie_co/presentation/screens/social_feed/tabs/leaderboard_tab.dart';
import 'package:bizzie_co/presentation/screens/social_feed/tabs/my_activity_tab.dart';
import 'package:bizzie_co/presentation/widgets/animated_toggle.dart';
import 'package:flutter/material.dart';

class SocialFeed extends StatefulWidget {
  const SocialFeed({Key? key, required this.parentContext}) : super(key: key);
  final BuildContext parentContext;
  @override
  State<SocialFeed> createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  int _selectedTab = 0;

  final List<Widget> _tabs = const [
    ConnectionsTab(),
    LeaderboardTab(),
    MyActivityTab()
  ];

  @override
  void initState() {
    super.initState();

    // BlocProvider.of<ActivityBloc>(context).add(LoadActivity());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AnimatedToggle(
                  values: const ['Connections', 'Leaderboard', 'My Activity'],
                  onToggleCallback: (value) {
                    setState(() {
                      _selectedTab = value;
                    });
                  }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ConnectionsTab()
//
          // IndexedStack(
          // index: _selectedTab,
          // children: _tabs,
          // )
          _tabs[_selectedTab]
        ],
      ),
    );
  }
}
