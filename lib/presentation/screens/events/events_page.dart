import 'package:bizzie_co/business_logic/bloc/Event/events_bloc.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:flutter/material.dart';
import 'components/event_item_list.dart';
import 'components/events_heading.dart';
import 'components/events_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EventsHeading(user: user),

          // TODO : Featured search
          // const EventsSearch(),

          // TODO : Featured events
          // const FeaturedEvents(),
          const EventsTitle(
            title: 'Events',
          ),
          BlocBuilder<EventBloc, EventsState>(
            builder: (context, state) {
              if (state is EventsLoaded) {
                final events = state.events;
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return EventItemList(
                        event: events[index],
                      );
                    });
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
