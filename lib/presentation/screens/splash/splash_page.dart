import 'dart:async';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/initial_screen.dart';
import 'package:bizzie_co/presentation/screens/authentication/user_info.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';
import 'package:bizzie_co/presentation/screens/profile/card/card_detail_page.dart';
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
          width: width / 1.5,
          child: Image.asset(
            'assets/images/bizzieco_logo.png',
            // fit: BoxFit.fitWidth,
            // scale: 0.5,
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
      User? user = await FirestoreService()
          .loadUserData(userUid: AuthenticationService().getUser()!.uid);

      if (user == null) {
        logoutUser();
        return;
      }

      if (user.firstName == null ||
          user.lastName == null ||
          user.phone == null) {
        initialRout = UserInfoPage.id;
      } else {
        final UserCard? card = await FirestoreService()
            .getCardData(userUid: user.uid, cardUid: user.primaryCard!);

        if (card == null) {
          initialRout = CardDetailPage.id;
        } else {
          final cards = await FirestoreService()
              .getAllCards(userUid: FirestoreService.currentUser!.uid);
          FirestoreService.setUserCards(cards);

          final tickets = await FirestoreService()
              .getTickets(userUid: FirestoreService.currentUser!.uid);
          FirestoreService.setTickets(tickets);
          initialRout = HomePage.id;
        }
      }
    }
    Timer(const Duration(milliseconds: 500), () {
      Navigator.pushNamedAndRemoveUntil(
          context, initialRout, ModalRoute.withName(initialRout));
    });
  }

  Future<void> logoutUser() async {
    await AuthenticationService().userSignOut();
    if (!AuthenticationService().isSignedIn()) {
      Navigator.pushNamedAndRemoveUntil(
          context, InitialPage.id, ModalRoute.withName(InitialPage.id));

      FirestoreService.resetUser();
    }
  }
}
