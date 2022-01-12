import 'dart:developer';

import 'package:bizzie_co/business_logic/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/rank_item.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/rank_item_list.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UsersRank extends StatelessWidget {
  const UsersRank({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        BlocBuilder<LeaderboardBloc, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardLoaded) {
              List<User> users = state.users;
              if (users.length >= 3) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      // color: Colors.lightGreen,
                      height: width * 0.7,
                      width: width,
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Align(
                                  child: RankItem(
                                      rank: Rank.first, user: users[0]))),
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child:
                                  RankItem(rank: Rank.second, user: users[1])),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child:
                                  RankItem(rank: Rank.third, user: users[2])),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: users.length - 3,
                      itemBuilder: (context, index) {
                        //? Fetch data of the user who has this activity

                        return Column(
                          children: [
                            RankItemList(
                              user: users[index + 3],
                              rank: index + 4,
                            ),
                            // if (index != 6)
                            const Divider(
                              indent: 30,
                              endIndent: 30,
                            ),
                          ],
                        );
                      },
                    )
                  ],
                );
              } else {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    //? Fetch data of the user who has this activity

                    return Column(
                      children: [
                        RankItemList(
                          user: users[index],
                          rank: index + 1,
                        ),
                        // if (index != 6)
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                        ),
                      ],
                    );
                  },
                );
              }
            } else if (state is LeaderboardLoading) {
              return const Center(child: Text('nothing'));
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
