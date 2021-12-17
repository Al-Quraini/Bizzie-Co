part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class CancelActivity extends ActivityEvent {}

class LoadActivity extends ActivityEvent {}

class UpdateActivity extends ActivityEvent {
  final List<Activity> activities;

  const UpdateActivity(this.activities);

  @override
  List<Object> get props => [activities];
}
