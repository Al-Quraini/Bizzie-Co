import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/presentation/screens/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const String id = '/profile_page';
  const ProfilePage(
      {Key? key,
      required this.user,
      required this.card,
      required this.isMyProfile,
      required this.cards})
      : super(key: key);

  final User user;
  final UserCard card;
  final List<UserCard> cards;
  final bool isMyProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileTab(
        user: user,
        card: card,
        cards: cards,
        isMyProfile: false,
      ),
    );
  }
}
