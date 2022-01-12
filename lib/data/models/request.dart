import 'dart:convert';

class Request {
  String? _imageUrl;

  set setUrl(String? url) {
    _imageUrl = url;
  }

  String? get userImage {
    return _imageUrl;
  }

  final String requestFrom;
  final String requestTo;
  final DateTime timestamp;
  final bool isPending;
  final String userFirstName;
  final String userLastName;
  final String? industry;
  final String? userImagePath;
  Request({
    required this.requestFrom,
    required this.requestTo,
    required this.timestamp,
    required this.isPending,
    required this.userFirstName,
    required this.userLastName,
    this.industry,
    this.userImagePath,
  });

  Request copyWith({
    String? requestFrom,
    String? requestTo,
    DateTime? timestamp,
    bool? isPending,
    String? userFirstName,
    String? userLastName,
    String? industry,
    String? userImagePath,
  }) {
    return Request(
      requestFrom: requestFrom ?? this.requestFrom,
      requestTo: requestTo ?? this.requestTo,
      timestamp: timestamp ?? this.timestamp,
      isPending: isPending ?? this.isPending,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      industry: industry ?? this.industry,
      userImagePath: userImagePath ?? this.userImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestFrom': requestFrom,
      'requestTo': requestTo,
      'timestamp': timestamp,
      'isPending': isPending,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'industry': industry,
      'userImagePath': userImagePath,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      requestFrom: map['requestFrom'] ?? '',
      requestTo: map['requestTo'] ?? '',
      timestamp: map['timestamp'].toDate(),
      isPending: map['isPending'] ?? false,
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      industry: map['industry'],
      userImagePath: map['userImagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) =>
      Request.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Request(requestFrom: $requestFrom, requestTo: $requestTo, timestamp: $timestamp, isPending: $isPending, userFirstName: $userFirstName, userLastName: $userLastName, industry: $industry, userImagePath: $userImagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Request &&
        other.requestFrom == requestFrom &&
        other.requestTo == requestTo &&
        other.timestamp == timestamp &&
        other.isPending == isPending &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.industry == industry &&
        other.userImagePath == userImagePath;
  }

  @override
  int get hashCode {
    return requestFrom.hashCode ^
        requestTo.hashCode ^
        timestamp.hashCode ^
        isPending.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        industry.hashCode ^
        userImagePath.hashCode;
  }
}
