part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class InitializeNotification extends NotificationEvent {}

class LoadNotification extends NotificationEvent {}

class UpdateNotification extends NotificationEvent {
  final List<NotificationModel> notifications;

  const UpdateNotification(this.notifications);

  @override
  List<Object?> get props => [notifications];
}
