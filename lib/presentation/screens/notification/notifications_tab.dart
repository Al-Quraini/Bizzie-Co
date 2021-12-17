import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/notification/components/notification_item_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
            if (state is NotificationLoaded) {
              List<NotificationModel> notifications = state.notifications;

              List<String> notificationsFromList = notifications
                  .map((element) => element.notificationFrom)
                  .toList();
              List<User> users = FirestoreService.myConnections
                  .where(
                      (element) => notificationsFromList.contains(element.uid))
                  .toList();
              users.add(FirestoreService.currentUser!);
              // FirestoreService().getRequests(snapshot);
              if (notifications.isNotEmpty) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final thisUser = users.firstWhere((element) =>
                        element.uid == notifications[index].notificationFrom);
                    return NotificationItemList(
                      notification: notifications[index],
                      user: thisUser,
                    );
                  },
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text('There are no requests for you'),
                );
              }
            } else {
              return Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
          }),
          // const Divider(
          //   indent: 20,
          //   endIndent: 20,
          // ),
        ],
      ),
    );
  }
}
