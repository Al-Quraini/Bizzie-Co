import 'dart:convert';

import 'package:bizzie_co/data/service/storage_service.dart';

class Comment {
  String? _imageUrl;

  set setUrl(String? url) {
    _imageUrl = url;
  }

  String? get userImage {
    return _imageUrl;
  }

  final String text;
  final DateTime timestamp;
  final String commentUid;
  final String userUid;
  final String postUid;
  final String userFirstName;
  final String userLastName;
  final String? industry;
  final String? userImagePath;

  Comment({
    required this.text,
    required this.timestamp,
    required this.commentUid,
    required this.userUid,
    required this.postUid,
    required this.userFirstName,
    required this.userLastName,
    this.industry,
    this.userImagePath,
  });

  Comment copyWith({
    String? text,
    DateTime? timestamp,
    String? commentUid,
    String? userUid,
    String? postUid,
    String? userFirstName,
    String? userLastName,
    String? industry,
    String? userImagePath,
  }) {
    return Comment(
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      commentUid: commentUid ?? this.commentUid,
      userUid: userUid ?? this.userUid,
      postUid: postUid ?? this.postUid,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userImagePath: userImagePath ?? this.userImagePath,
      industry: industry ?? this.industry,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp,
      'commentUid': commentUid,
      'userUid': userUid,
      'postUid': postUid,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'industry': industry,
      'userImagePath': userImagePath,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      text: map['text'] ?? '',
      timestamp: map['timestamp'].toDate(),
      commentUid: map['commentUid'] ?? '',
      userUid: map['userUid'] ?? '',
      postUid: map['postUid'] ?? '',
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      industry: map['industry'],
      userImagePath: map['userImagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(text: $text, timestamp: $timestamp, commentUid: $commentUid, userUid: $userUid, postUid: $postUid, userFirstName: $userFirstName, userLastName: $userLastName, industry: $industry, userImagePath: $userImagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.text == text &&
        other.timestamp == timestamp &&
        other.commentUid == commentUid &&
        other.userUid == userUid &&
        other.postUid == postUid &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.industry == industry &&
        other.userImagePath == userImagePath;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        timestamp.hashCode ^
        commentUid.hashCode ^
        userUid.hashCode ^
        postUid.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        industry.hashCode ^
        userImagePath.hashCode;
  }
}
