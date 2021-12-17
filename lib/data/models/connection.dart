import 'dart:convert';

class Connection {
  final DateTime timeStamp;
  final String userUid;
  Connection({
    required this.timeStamp,
    required this.userUid,
  });

  Connection copyWith({
    DateTime? timeStamp,
    String? userUid,
  }) {
    return Connection(
      timeStamp: timeStamp ?? this.timeStamp,
      userUid: userUid ?? this.userUid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'userUid': userUid,
    };
  }

  factory Connection.fromMap(Map<String, dynamic> map) {
    return Connection(
      timeStamp: map['timeStamp'].toDate(),
      userUid: map['userUid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Connection.fromJson(String source) =>
      Connection.fromMap(json.decode(source));

  @override
  String toString() => 'Connection(timeStamp: $timeStamp, userUid: $userUid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Connection &&
        other.timeStamp == timeStamp &&
        other.userUid == userUid;
  }

  @override
  int get hashCode => timeStamp.hashCode ^ userUid.hashCode;
}
