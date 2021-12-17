import 'dart:convert';
import 'package:enum_to_string/enum_to_string.dart';

class NotificationModel {
  final DateTime timeStamp;
  final NotificationType notificationType;
  final String notificationFrom;
  final bool isRead;
  NotificationModel({
    required this.timeStamp,
    required this.notificationType,
    required this.notificationFrom,
    this.isRead = false,
  });

  NotificationModel copyWith({
    DateTime? timeStamp,
    NotificationType? notificationType,
    String? notificationFrom,
    bool? isRead,
  }) {
    return NotificationModel(
      timeStamp: timeStamp ?? this.timeStamp,
      notificationType: notificationType ?? this.notificationType,
      notificationFrom: notificationFrom ?? this.notificationFrom,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'notificationType': EnumToString.convertToString(notificationType),
      'notificationFrom': notificationFrom,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      timeStamp: map['timeStamp'].toDate(),
      notificationType: EnumToString.fromString(
              NotificationType.values, map['notificationType']) ??
          NotificationType.like,
      notificationFrom: map['notificationFrom'],
      isRead: map['isRead'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(timeStamp: $timeStamp, notificationType: $notificationType, notificationFrom: $notificationFrom, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.timeStamp == timeStamp &&
        other.notificationType == notificationType &&
        other.notificationFrom == notificationFrom &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return timeStamp.hashCode ^
        notificationType.hashCode ^
        notificationFrom.hashCode ^
        isRead.hashCode;
  }
}

enum NotificationType {
  request,
  like,
  newConnection,
}
