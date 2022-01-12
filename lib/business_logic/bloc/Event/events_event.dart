part of 'events_bloc.dart';

@immutable
abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class ResetEvents extends EventsEvent {}

class LoadEvents extends EventsEvent {}

class UpdateEvents extends EventsEvent {
  final List<Event> events;

  const UpdateEvents(this.events);

  @override
  List<Object> get props => [events];
}
