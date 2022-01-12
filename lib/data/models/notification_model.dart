import 'dart:convert';

import 'package:bizzie_co/utils/enums.dart';
import 'package:enum_to_string/enum_to_string.dart';

class NotificationModel {
  String? _imageUrl;

  set setUrl(String? url) {
    _imageUrl = url;
  }

  String? get userImage {
    return _imageUrl;
  }

  final DateTime timestamp;
  final NotificationType notificationType;
  final String notificationFrom;
  final bool isRead;
  final String userFirstName;
  final String notificationId;
  final String userLastName;
  final String? industry;
  final String? userImagePath;
  NotificationModel({
    required this.timestamp,
    required this.notificationType,
    required this.notificationFrom,
    this.isRead = false,
    required this.userFirstName,
    required this.notificationId,
    required this.userLastName,
    this.industry,
    this.userImagePath,
  });

  NotificationModel copyWith({
    DateTime? timestamp,
    NotificationType? notificationType,
    String? notificationFrom,
    bool? isRead,
    String? userFirstName,
    String? notificationId,
    String? userLastName,
    String? industry,
    String? userImagePath,
  }) {
    return NotificationModel(
      timestamp: timestamp ?? this.timestamp,
      notificationType: notificationType ?? this.notificationType,
      notificationFrom: notificationFrom ?? this.notificationFrom,
      isRead: isRead ?? this.isRead,
      notificationId: notificationId ?? this.notificationId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      industry: industry ?? this.industry,
      userImagePath: userImagePath ?? this.userImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'notificationType': EnumToString.convertToString(notificationType),
      'notificationFrom': notificationFrom,
      'isRead': isRead,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'notificationId': notificationId,
      'industry': industry,
      'userImagePath': userImagePath,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      timestamp: map['timestamp'].toDate(),
      notificationType: EnumToString.fromString(
              NotificationType.values, map['notificationType']) ??
          NotificationType.like,
      notificationFrom: map['notificationFrom'] ?? '',
      isRead: map['isRead'] ?? false,
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      industry: map['industry'],
      notificationId: map['notificationId'] ?? '',
      userImagePath: map['userImagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(timestamp: $timestamp, notificationType: $notificationType, notificationFrom: $notificationFrom, isRead: $isRead, userFirstName: $userFirstName, userLastName: $userLastName, industry: $industry, userImagePath: $userImagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.timestamp == timestamp &&
        other.notificationType == notificationType &&
        other.notificationFrom == notificationFrom &&
        other.isRead == isRead &&
        other.userFirstName == userFirstName &&
        other.notificationId == notificationId &&
        other.userLastName == userLastName &&
        other.industry == industry &&
        other.userImagePath == userImagePath;
  }

  @override
  int get hashCode {
    return timestamp.hashCode ^
        notificationType.hashCode ^
        notificationFrom.hashCode ^
        isRead.hashCode ^
        userFirstName.hashCode ^
        notificationId.hashCode ^
        userLastName.hashCode ^
        industry.hashCode ^
        userImagePath.hashCode;
  }
}
