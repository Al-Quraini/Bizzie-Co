import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/presentation/screens/social_feed/components/activity_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ConnectionsTab extends StatelessWidget {
  const ConnectionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        // if the activity list loaded successfully, show the list in the ui
        if (state is ActivityLoaded) {
          //? filter the list of activities by removing current user's activities
          final List<Activity> activities = state.activities;

          //* check if there are activities
          if (state.activities.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ActivityItemList(
                      key: key,
                      activity: activities[index],
                    ),
                    if (index != activities.length - 1 &&
                        !activities[index].isSponsored)
                      const Divider(
                        indent: 20,
                        endIndent: 20,
                      )
                    else
                      const SizedBox(
                        height: 15,
                      )
                  ],
                );
              },
            );
          }
          //! if there are no activities, display this message
          else {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: const Text('There are no activities for you'),
            );
          }
        }
        // display the indicator
        else if (state is InitialConnectionState) {
          return shimmerWidget(width);
        } else {
          return shimmerWidget(width);
        }
      },
    );
  }

  ListView shimmerWidget(double width) {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, indx) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 70,
                    width: 70,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 20,
                        width: width * 0.35,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 30,
                        width: width * 0.55,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
