part of 'notification_alert_cubit.dart';

@immutable
abstract class NotificationAlertState {}

class NotificationAlertInitial extends NotificationAlertState {}

class NotificationAlertActive extends NotificationAlertState {}

class NotificationAlertInActive extends NotificationAlertState {}
