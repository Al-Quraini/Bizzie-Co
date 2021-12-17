import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/presentation/screens/social_feed/connections_tab.dart';
import 'package:bizzie_co/presentation/screens/social_feed/my_activity_tab.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialFeed extends StatefulWidget {
  const SocialFeed({Key? key}) : super(key: key);

  @override
  State<SocialFeed> createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  List<bool> _selectedTabList = [true, false];
  int _selectedTab = 0;

  final List<Widget> _tabs = const [ConnectionsTab(), MyActivityTab()];

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
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  color: toggleBtnBackground
                  //Color.fromRGBO(108, 101, 172, 1),
                  ),
              width: 0.8 * width,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: LayoutBuilder(builder: (context, constraints) {
                  return ToggleButtons(
                    borderColor: Colors.transparent,
                    constraints: BoxConstraints.expand(
                        width: constraints.maxWidth / 2 - 2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    selectedColor: Colors.black,
                    fillColor: Colors.white,
                    children: <Widget>[
                      Text(
                        'Connections',
                        style: GoogleFonts.quicksand(fontSize: 14),
                      ),
                      Text(
                        'My Activity',
                        style: GoogleFonts.quicksand(fontSize: 14),
                      ),
                    ],
                    onPressed: (int index) {
                      _selectedTabList = [false, false];
                      setState(() {
                        _selectedTabList[index] = true;
                        _selectedTab = index;
                      });
                    },
                    isSelected: _selectedTabList,
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // ConnectionsTab()

          _tabs[_selectedTab]
        ],
      ),
    );
  }
}
