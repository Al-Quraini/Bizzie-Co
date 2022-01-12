import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/request/request_bloc.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/presentation/screens/events/add_event_page.dart';
import 'package:bizzie_co/presentation/screens/notification/notification_page.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie_co/utils/extension.dart';

class EventsHeading extends StatelessWidget {
  const EventsHeading({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${user.firstName}',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                      ('${user.location?.city ?? ''}, ') +
                          (user.location?.state ?? 'no location yet'),
                      style: GoogleFonts.quicksand(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            // alignment: Alignment.center,
            height: 30,
            width: 30,
            // height: 30,
            // width: 30,
            // padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddEventPage()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NotificationPage()));
            },
            icon: BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                bool showAlert = false;
                bool isThereNew = false;
                if (state is RequestLoaded) {
                  isThereNew = state.requests.isNotEmpty;
                }

                return BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                    List<bool> notfications = [];
                    if (state is NotificationLoaded) {
                      notfications = state.notifications
                          .map((notification) => notification.isRead)
                          .toList();

                      showAlert = isThereNew || notfications.contains(false);
                    }
                    return Stack(
                      children: [
                        const Icon(
                          Icons.notifications_none,
                          size: 35,
                        ),
                        if (showAlert)
                          const Positioned(
                            right: 3,
                            top: 5,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: secondary,
                            ),
                          )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
