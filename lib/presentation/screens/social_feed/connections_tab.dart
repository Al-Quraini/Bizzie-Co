import 'dart:developer';

import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/activity_item_list.dart';

class ConnectionsTab extends StatelessWidget {
  const ConnectionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        // if the activity list loaded successfully, show the list in the ui
        if (state is ActivityLoaded) {
          List<User> users = FirestoreService.myConnections;

          //? filter the list of activities by removing current user's activities
          final List<Activity> activities = state.activities
              .where((element) =>
                  element.activityUser != FirestoreService.currentUser!.uid)
              .toList();

          //* check if there are activities
          if (activities.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                //? Fetch data of the user who has this activity
                final user = users.firstWhere(
                    (user) => user.uid == activities[index].activityUser);

                return Column(
                  children: [
                    ActivityItemList(
                      activity: activities[index],
                      user: user,
                    ),
                    if (index != activities.length - 1)
                      const Divider(
                        indent: 20,
                        endIndent: 20,
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
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: const Text('Loading...'),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: const Text('no items for you'),
          );
        }
      },
    );
  }
}
