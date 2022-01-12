part of 'events_bloc.dart';

@immutable
abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

class InitialEventsState extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;

  const EventsLoaded({this.events = const <Event>[]});

  @override
  List<Object?> get props => [events];
}
