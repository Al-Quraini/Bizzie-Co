part of 'my_activity_bloc.dart';

@immutable
abstract class MyActivityState extends Equatable {
  const MyActivityState();
  @override
  List<Object?> get props => [];
}

class MyActivityInitial extends MyActivityState {}

class MyActivityLoading extends MyActivityState {}

class MyActivityLoaded extends MyActivityState {
  final List<Activity> activities;

  const MyActivityLoaded({this.activities = const <Activity>[]});

  @override
  List<Object?> get props => [activities];
}
