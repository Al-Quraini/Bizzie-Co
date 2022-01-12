import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/industry_indicator.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/my_rank.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/rank_text.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/user_rank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO : later work on connections leaderboard
class LeaderConnectinosTab extends StatelessWidget {
  const LeaderConnectinosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // final User user = FirestoreService.currentUser!;
    return Column(
      children: const [
        /*  MyRank(user: FirestoreService.currentUser!),
        const SizedBox(
          height: 20,
        ),
        const RrankText(
          title: 'Top Users',
        ),
        const SizedBox(
          height: 10,
        ),
        UsersRank(user: FirestoreService.currentUser!),
        const SizedBox(
          height: 20,
        ),
        const RrankText(
          title: 'Top Industries',
        ),
        const SizedBox(
          height: 25,
        ),

        /* -------------------------------------------------------------------------- */
        /*                              start of industries                             */
        /* -------------------------------------------------------------------------- */

        /* -------------------------------------------------------------------------- */
        /*                              end of industries                             */
        /* -------------------------------------------------------------------------- */
        const SizedBox(
          height: 20,
        ),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
        const SizedBox(
          height: 15,
        ),
        const RrankText(
          title: 'Top Areas',
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                'assets/images/map.jpeg',
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(
          height: 40,
        ), */
      ],
    );
  }
}
