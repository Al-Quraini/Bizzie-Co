import 'dart:convert';

import 'package:flutter/foundation.dart';

class Event {
  String? _userImageUrl;

  set setUserUrl(String? url) {
    _userImageUrl = url;
  }

  String? get userImage {
    return _userImageUrl;
  }

  String? _eventImage;

  set setEventUrl(String? url) {
    _eventImage = url;
  }

  String? get eventImageUrl {
    return _eventImage;
  }

  final String id;
  final String userUid;
  final String venue;
  final String title;
  final DateTime time;
  final DateTime timestamp;
  final String imagePath;
  final double price;
  final int max;
  final int duration;
  final bool isRefundable;
  final String details;
  final String address;
  final String userFirstName;
  final String userLastName;
  final List<String> industries;
  final String? userImagePath;
  Event({
    required this.id,
    required this.userUid,
    required this.venue,
    required this.title,
    required this.time,
    required this.timestamp,
    required this.imagePath,
    required this.price,
    required this.max,
    required this.duration,
    this.isRefundable = false,
    required this.details,
    required this.address,
    required this.userFirstName,
    required this.userLastName,
    required this.industries,
    this.userImagePath,
  });

  Event copyWith({
    String? eventId,
    String? userUid,
    String? eventVenue,
    String? eventTitle,
    DateTime? eventTime,
    DateTime? timestamp,
    String? eventImagePath,
    double? price,
    int? eventMax,
    int? eventDuration,
    bool? isRefundable,
    String? eventDetails,
    String? address,
    String? userFirstName,
    String? userLastName,
    List<String>? industries,
    String? userImagePath,
  }) {
    return Event(
      id: eventId ?? this.id,
      userUid: userUid ?? this.userUid,
      venue: eventVenue ?? this.venue,
      title: eventTitle ?? this.title,
      time: eventTime ?? this.time,
      timestamp: timestamp ?? this.timestamp,
      imagePath: eventImagePath ?? this.imagePath,
      price: price ?? this.price,
      max: eventMax ?? this.max,
      duration: eventDuration ?? this.duration,
      isRefundable: isRefundable ?? this.isRefundable,
      details: eventDetails ?? this.details,
      address: address ?? this.address,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      industries: industries ?? this.industries,
      userImagePath: userImagePath ?? this.userImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': id,
      'userUid': userUid,
      'eventVenue': venue,
      'eventTitle': title,
      'eventTime': time.millisecondsSinceEpoch,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'eventImagePath': imagePath,
      'price': price,
      'eventMax': max,
      'eventDuration': duration,
      'isRefundable': isRefundable,
      'eventDetails': details,
      'address': address,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'industries': industries,
      'userImagePath': userImagePath,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['eventId'] ?? '',
      userUid: map['userUid'] ?? '',
      venue: map['eventVenue'] ?? '',
      title: map['eventTitle'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['eventTime']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      imagePath: map['eventImagePath'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      max: map['eventMax']?.toInt() ?? 0,
      duration: map['eventDuration']?.toInt() ?? 0,
      isRefundable: map['isRefundable'] ?? false,
      details: map['eventDetails'] ?? '',
      address: map['address'] ?? '',
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      industries: List<String>.from(map['industries']),
      userImagePath: map['userImagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(eventId: $id, userUid: $userUid, eventVenue: $venue, eventTitle: $title, eventTime: $time, timestamp: $timestamp, eventImagePath: $imagePath, price: $price, eventMax: $max, eventDuration: $duration, isRefundable: $isRefundable, eventDetails: $details, address: $address, userFirstName: $userFirstName, userLastName: $userLastName, industries: $industries, userImagePath: $userImagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.userUid == userUid &&
        other.venue == venue &&
        other.title == title &&
        other.time == time &&
        other.timestamp == timestamp &&
        other.imagePath == imagePath &&
        other.price == price &&
        other.max == max &&
        other.duration == duration &&
        other.isRefundable == isRefundable &&
        other.details == details &&
        other.address == address &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        listEquals(other.industries, industries) &&
        other.userImagePath == userImagePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userUid.hashCode ^
        venue.hashCode ^
        title.hashCode ^
        time.hashCode ^
        timestamp.hashCode ^
        imagePath.hashCode ^
        price.hashCode ^
        max.hashCode ^
        duration.hashCode ^
        isRefundable.hashCode ^
        details.hashCode ^
        address.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        industries.hashCode ^
        userImagePath.hashCode;
  }
}
