import 'dart:convert';

class Like {
  final DateTime timeStamp;
  final String likeDocId;
  Like({
    required this.timeStamp,
    required this.likeDocId,
  });

  Like copyWith({
    DateTime? timeStamp,
    String? likeDocId,
  }) {
    return Like(
      timeStamp: timeStamp ?? this.timeStamp,
      likeDocId: likeDocId ?? this.likeDocId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'likeDocId': likeDocId,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      timeStamp: map['timeStamp'].toDate(),
      likeDocId: map['likeDocId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));

  @override
  String toString() => 'Like(timeStamp: $timeStamp, likeDocId: $likeDocId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Like &&
        other.timeStamp == timeStamp &&
        other.likeDocId == likeDocId;
  }

  @override
  int get hashCode => timeStamp.hashCode ^ likeDocId.hashCode;
}
