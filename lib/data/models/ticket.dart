import 'dart:convert';

class Ticket {
  final String eventUid;
  final String userUid;
  final DateTime timeStamp;
  final String eventTitle;
  final String eventVenue;
  final DateTime eventTime;
  final int eventDuration;
  Ticket({
    required this.eventUid,
    required this.userUid,
    required this.timeStamp,
    required this.eventTitle,
    required this.eventVenue,
    required this.eventTime,
    required this.eventDuration,
  });

  Ticket copyWith({
    String? eventUid,
    String? userUid,
    DateTime? timeStamp,
    String? eventTitle,
    String? eventVenue,
    DateTime? eventTime,
    int? eventDuration,
  }) {
    return Ticket(
      eventUid: eventUid ?? this.eventUid,
      userUid: userUid ?? this.userUid,
      timeStamp: timeStamp ?? this.timeStamp,
      eventTitle: eventTitle ?? this.eventTitle,
      eventVenue: eventVenue ?? this.eventVenue,
      eventTime: eventTime ?? this.eventTime,
      eventDuration: eventDuration ?? this.eventDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventUid': eventUid,
      'userUid': userUid,
      'timeStamp': timeStamp.millisecondsSinceEpoch,
      'eventTitle': eventTitle,
      'eventVenue': eventVenue,
      'eventTime': eventTime.millisecondsSinceEpoch,
      'eventDuration': eventDuration,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      eventUid: map['eventUid'] ?? '',
      userUid: map['userUid'] ?? '',
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp']),
      eventTitle: map['eventTitle'] ?? '',
      eventVenue: map['eventVenue'] ?? '',
      eventTime: DateTime.fromMillisecondsSinceEpoch(map['eventTime']),
      eventDuration: map['eventDuration']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) => Ticket.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ticket(eventUid: $eventUid, userUid: $userUid, timeStamp: $timeStamp, eventTitle: $eventTitle, eventVenue: $eventVenue, eventTime: $eventTime, eventDuration: $eventDuration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ticket &&
        other.eventUid == eventUid &&
        other.userUid == userUid &&
        other.timeStamp == timeStamp &&
        other.eventTitle == eventTitle &&
        other.eventVenue == eventVenue &&
        other.eventTime == eventTime &&
        other.eventDuration == eventDuration;
  }

  @override
  int get hashCode {
    return eventUid.hashCode ^
        userUid.hashCode ^
        timeStamp.hashCode ^
        eventTitle.hashCode ^
        eventVenue.hashCode ^
        eventTime.hashCode ^
        eventDuration.hashCode;
  }
}
