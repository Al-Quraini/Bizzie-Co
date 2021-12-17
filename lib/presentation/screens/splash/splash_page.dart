import 'dart:async';

import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/initial_screen.dart';
import 'package:bizzie_co/presentation/screens/authentication/login_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/user_info.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const String id = '/splash_page';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // AuthenticationService().userSignOut();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: SizedBox(
          child: SizedBox(
            width: width / 1.5,
            child: Image.asset(
              'assets/images/bizzieco_logo.png',
              // fit: BoxFit.fitWidth,
              // scale: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    String initialRout = InitialPage.id;
    bool isLoggedIn = AuthenticationService().isSignedIn() &&
        (AuthenticationService().getUser()?.emailVerified ?? false);

    if (isLoggedIn) {
      final user = await FirestoreService()
          .loadUserData(userUid: AuthenticationService().getUser()!.uid);

      if (user?.firstName == null ||
          user?.lastName == null ||
          user?.phone == null) {
        initialRout = UserInfoPage.id;
      } else {
        await FirestoreService()
            .getCardData(userUid: user!.uid, cardUid: user.primaryCard!);
        await FirestoreService().getConnections();
        initialRout = HomePage.id;
      }
    }
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, initialRout, ModalRoute.withName(initialRout));
    });
  }
}
