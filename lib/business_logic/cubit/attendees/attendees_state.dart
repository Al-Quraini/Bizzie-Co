part of 'attendees_cubit.dart';

@immutable
abstract class AttendeesState extends Equatable {
  const AttendeesState();
  @override
  List<Object?> get props => [];
}

class AttendeesInitial extends AttendeesState {}

class AttendeesLoading extends AttendeesState {}

class AttendeesLoaded extends AttendeesState {
  final List<Attendee> attendees;

  const AttendeesLoaded({this.attendees = const <Attendee>[]});

  @override
  List<Object?> get props => [attendees];
}
