import 'dart:convert';

import 'package:bizzie_co/data/service/storage_service.dart';

class Connection {
  String? _imageUrl;

  set setUrl(String? url) {
    _imageUrl = url;
  }

  String? get userImage {
    return _imageUrl;
  }

  final DateTime timestamp;
  final bool isMuted;
  final String userUid;
  final String userFirstName;
  final String userLastName;
  final String? industry;
  final String? userImagePath;

  Connection({
    required this.timestamp,
    this.isMuted = false,
    required this.userUid,
    required this.userFirstName,
    required this.userLastName,
    this.industry,
    this.userImagePath,
  });

  Connection copyWith({
    DateTime? timestamp,
    bool? isMuted,
    String? userUid,
    String? userFirstName,
    String? userLastName,
    String? industry,
    String? userImagePath,
  }) {
    return Connection(
      timestamp: timestamp ?? this.timestamp,
      isMuted: isMuted ?? this.isMuted,
      userUid: userUid ?? this.userUid,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      industry: industry ?? this.industry,
      userImagePath: userImagePath ?? this.userImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'isMuted': isMuted,
      'userUid': userUid,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'industry': industry,
      'userImagePath': userImagePath,
    };
  }

  factory Connection.fromMap(Map<String, dynamic> map) {
    return Connection(
      timestamp: map['timestamp'].toDate(),
      isMuted: map['isMuted'] ?? false,
      userUid: map['userUid'] ?? '',
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      industry: map['industry'],
      userImagePath: map['userImagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Connection.fromJson(String source) =>
      Connection.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Connection(timestamp: $timestamp, isMuted: $isMuted, userUid: $userUid, userFirstName: $userFirstName, userLastName: $userLastName, industry: $industry, userImagePath: $userImagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Connection &&
        other.timestamp == timestamp &&
        other.isMuted == isMuted &&
        other.userUid == userUid &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.industry == industry &&
        other.userImagePath == userImagePath;
  }

  @override
  int get hashCode {
    return timestamp.hashCode ^
        isMuted.hashCode ^
        userUid.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        industry.hashCode ^
        userImagePath.hashCode;
  }
}
