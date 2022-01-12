import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/notification/components/notification_item_list.dart';
import 'package:flutter/material.dart';
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
              for (var notification in notifications) {
                if (!notification.isRead) {
                  FirestoreService().readNotification(
                      notificationId: notification.notificationId);
                }
              }

              // FirestoreService().getRequests(snapshot);
              if (notifications.isNotEmpty) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationItemList(
                      notification: notifications[index],
                    );
                  },
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const Text('There are no notifications for you'),
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
