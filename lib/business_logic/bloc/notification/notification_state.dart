part of 'notification_bloc.dart';

@immutable
abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;


  const NotificationLoaded(
      {this.notifications = const <NotificationModel>[],
      });

  @override
  List<Object?> get props => [notifications,];
}
