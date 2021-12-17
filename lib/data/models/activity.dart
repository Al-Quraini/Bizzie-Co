import 'dart:convert';

class Activity {
  final DateTime timeStamp;
  final String description;
  final String activityUser;
  final String? recieverUser;
  final String activityUid;

  Activity({
    required this.timeStamp,
    required this.description,
    required this.activityUser,
    this.recieverUser,
    required this.activityUid,
  });

  Activity copyWith({
    DateTime? timeStamp,
    String? description,
    String? activityUser,
    String? recieverUser,
    String? activityUid,
  }) {
    return Activity(
      timeStamp: timeStamp ?? this.timeStamp,
      description: description ?? this.description,
      activityUser: activityUser ?? this.activityUser,
      recieverUser: recieverUser ?? this.recieverUser,
      activityUid: activityUid ?? this.activityUid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'description': description,
      'activityUser': activityUser,
      'recieverUser': recieverUser,
      'activityUid': activityUid,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      timeStamp: map['timeStamp'].toDate() ?? DateTime.now(),
      description: map['description'],
      activityUser: map['activityUser'],
      recieverUser: map['recieverUser'],
      activityUid: map['activityUid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Activity(timeStamp: $timeStamp, description: $description, activityUser: $activityUser, recieverUser: $recieverUser, activityUid: $activityUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.timeStamp == timeStamp &&
        other.description == description &&
        other.activityUser == activityUser &&
        other.recieverUser == recieverUser &&
        other.activityUid == activityUid;
  }

  @override
  int get hashCode {
    return timeStamp.hashCode ^
        description.hashCode ^
        activityUser.hashCode ^
        recieverUser.hashCode ^
        activityUid.hashCode;
  }
}
