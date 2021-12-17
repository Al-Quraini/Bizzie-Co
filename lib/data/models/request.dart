import 'dart:convert';

class Request {
  final String requestFrom;
  final String requestTo;
  final DateTime dateTime;
  final bool isPending;
  Request({
    required this.requestFrom,
    required this.requestTo,
    required this.dateTime,
    required this.isPending,
  });

  Request copyWith({
    String? requestFrom,
    String? requestTo,
    DateTime? dateTime,
    bool? isPending,
  }) {
    return Request(
      requestFrom: requestFrom ?? this.requestFrom,
      requestTo: requestTo ?? this.requestTo,
      dateTime: dateTime ?? this.dateTime,
      isPending: isPending ?? this.isPending,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestFrom': requestFrom,
      'requestTo': requestTo,
      'dateTime': dateTime,
      'isPending': isPending,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      requestFrom: map['requestFrom'],
      requestTo: map['requestTo'],
      dateTime: map['dateTime'].toDate(),
      isPending: map['isPending'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) =>
      Request.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Request(requestFrom: $requestFrom, requestTo: $requestTo, dateTime: $dateTime, isPending: $isPending)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Request &&
        other.requestFrom == requestFrom &&
        other.requestTo == requestTo &&
        other.dateTime == dateTime &&
        other.isPending == isPending;
  }

  @override
  int get hashCode {
    return requestFrom.hashCode ^
        requestTo.hashCode ^
        dateTime.hashCode ^
        isPending.hashCode;
  }
}
