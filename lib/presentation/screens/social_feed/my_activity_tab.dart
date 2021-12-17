import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/activity_item_list.dart';

class MyActivityTab extends StatelessWidget {
  const MyActivityTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!, width: 1)),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: const TextField(
            decoration: InputDecoration(
                hintText: 'search connections',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state is ActivityLoaded) {
              final currentUser = FirestoreService.currentUser!;
              List<User> users = FirestoreService.myConnections;
              users.add(currentUser);
              final List<Activity> activities = state.activities
                  .where((element) =>
                      (element.activityUser == currentUser.uid) ||
                      (element.recieverUser == currentUser.uid))
                  .toList();
              if (activities.isNotEmpty) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final user = users.firstWhere(
                        (user) => user.uid == activities[index].activityUser);
                    return Column(
                      children: [
                        ActivityItemList(
                          activity: activities[index],
                          user: user,
                          isMyActivity: true,
                        ),
                        if (index != activities.length - 1)
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          )
                        else
                          const SizedBox(
                            height: 25,
                          )
                      ],
                    );
                  },
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text('There are no activities for you'),
                );
              }
            } else {
              return Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: const Text('Loading...'),
              );
            }
          },
        )
      ],
    );
  }
}
