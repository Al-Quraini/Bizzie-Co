import 'package:bizzie_co/business_logic/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:bizzie_co/data/models/industry.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/industry_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndustriesRanking extends StatelessWidget {
  const IndustriesRanking({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoaded) {
          List<Industry> industries = state.industries;
          double heighstValue = industries[0].numOfUsers.toDouble();
          if (industries.isNotEmpty) {}
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: industries.length,
            itemBuilder: (context, index) {
              //? Fetch data of the user who has this activity

              return IdustryIndicator(
                index: index + 1,
                value: industries[index].numOfUsers.toDouble() /
                    heighstValue *
                    100,
                industry: industries[index],
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
