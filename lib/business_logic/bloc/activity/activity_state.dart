part of 'activity_bloc.dart';

@immutable
abstract class ActivityState extends Equatable {
  const ActivityState();
  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<Activity> activities;

  const ActivityLoaded({this.activities = const <Activity>[]});

  @override
  List<Object?> get props => [activities];
}
