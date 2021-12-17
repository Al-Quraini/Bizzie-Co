import 'dart:convert';

class UserNotification {
  final String userUid;
  final String docUid;
  final String description;
  final DateTime timeStamp;
  UserNotification({
    required this.userUid,
    required this.docUid,
    required this.description,
    required this.timeStamp,
  });

  UserNotification copyWith({
    String? userUid,
    String? docUid,
    String? description,
    DateTime? timeStamp,
  }) {
    return UserNotification(
      userUid: userUid ?? this.userUid,
      docUid: docUid ?? this.docUid,
      description: description ?? this.description,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'docUid': docUid,
      'description': description,
      'timeStamp': timeStamp,
    };
  }

  factory UserNotification.fromMap(Map<String, dynamic> map) {
    return UserNotification(
      userUid: map['userUid'],
      docUid: map['docUid'],
      description: map['description'],
      timeStamp: map['timeStamp'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserNotification.fromJson(String source) =>
      UserNotification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification(userUid: $userUid, docUid: $docUid, description: $description, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserNotification &&
        other.userUid == userUid &&
        other.docUid == docUid &&
        other.description == description &&
        other.timeStamp == timeStamp;
  }

  @override
  int get hashCode {
    return userUid.hashCode ^
        docUid.hashCode ^
        description.hashCode ^
        timeStamp.hashCode;
  }
}
