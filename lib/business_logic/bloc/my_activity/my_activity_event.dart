part of 'my_activity_bloc.dart';

@immutable
abstract class MyActivityEvent extends Equatable {
  const MyActivityEvent();

  @override
  List<Object> get props => [];
}

class CancelMyActivity extends MyActivityEvent {}

class LoadMyActivity extends MyActivityEvent {}

class UpdateMyActivity extends MyActivityEvent {
  final List<Activity> activities;

  const UpdateMyActivity(this.activities);

  @override
  List<Object> get props => [activities];
}
