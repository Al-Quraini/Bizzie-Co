import 'dart:convert';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:bizzie_co/utils/enums.dart';

class Activity {
  String? _userImageUrl;

  set setUserUrl(String? url) {
    _userImageUrl = url;
  }

  String? get userImage {
    return _userImageUrl;
  }

  String? _url;

  set setPhotoUrl(String? url) {
    _url = url;
  }

  String? get photoUrl {
    return _url;
  }

  final DateTime timestamp;
  final String? description;
  final String activityUser;
  final String? recieverUser;
  final String? url;
  final int numOfComments;
  bool isSponsored;
  final String activityUid;
  final String userFirstName;
  final String userLastName;
  final String? industry;
  final String? userImagePath;
  List<dynamic> likedBy;
  final ActivityVisibility visibility;

  Activity({
    required this.timestamp,
    required this.description,
    required this.activityUser,
    this.recieverUser,
    this.url,
    this.numOfComments = 0,
    this.visibility = ActivityVisibility.connections,
    this.isSponsored = false,
    required this.likedBy,
    required this.activityUid,
    required this.userFirstName,
    required this.userLastName,
    this.industry,
    this.userImagePath,
  });

  Activity copyWith({
    DateTime? timestamp,
    String? description,
    String? activityUser,
    String? recieverUser,
    String? url,
    ActivityVisibility? visibility,
    bool? isSponsored,
    int? numOfComments,
    String? activityUid,
    String? userFirstName,
    String? userLastName,
    List<dynamic>? likedBy,
    String? industry,
    String? userImagePath,
  }) {
    return Activity(
      timestamp: timestamp ?? this.timestamp,
      description: description ?? this.description,
      activityUser: activityUser ?? this.activityUser,
      recieverUser: recieverUser ?? this.recieverUser,
      url: url ?? this.url,
      numOfComments: numOfComments ?? this.numOfComments,
      isSponsored: isSponsored ?? this.isSponsored,
      visibility: visibility ?? this.visibility,
      activityUid: activityUid ?? this.activityUid,
      likedBy: likedBy ?? this.likedBy,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      industry: industry ?? this.industry,
      userImagePath: userImagePath ?? this.userImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'description': description,
      'activityUser': activityUser,
      'recieverUser': recieverUser,
      'url': url,
      'isSponsored': isSponsored,
      'numOfComments': numOfComments,
      'activityUid': activityUid,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'visibility': EnumToString.convertToString(visibility),
      'likedBy': likedBy,
      'industry': industry,
      'userImagePath': userImagePath,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      timestamp: map['timestamp'].toDate(),
      description: map['description'],
      activityUser: map['activityUser'] ?? '',
      recieverUser: map['recieverUser'],
      url: map['url'],
      numOfComments: map['numOfComments'],
      visibility: EnumToString.fromString(
              ActivityVisibility.values, map['visibility']) ??
          ActivityVisibility.connections,
      isSponsored: map['isSponsored'] ?? false,
      activityUid: map['activityUid'] ?? '',
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      likedBy: map['likedBy'],
      industry: map['industry'],
      userImagePath: map['userImagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Activity(timestamp: $timestamp, description: $description, activityUser: $activityUser, recieverUser: $recieverUser, url: $url, isSponsored: $isSponsored,visibility: $visibility, activityUid: $activityUid, userFirstName: $userFirstName, likedBy: $likedBy, userLastName: $userLastName, industry: $industry, userImagePath: $userImagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.timestamp == timestamp &&
        other.description == description &&
        other.activityUser == activityUser &&
        other.recieverUser == recieverUser &&
        other.url == url &&
        other.isSponsored == isSponsored &&
        other.visibility == visibility &&
        other.numOfComments == numOfComments &&
        other.likedBy == likedBy &&
        other.activityUid == activityUid &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.industry == industry &&
        other.userImagePath == userImagePath;
  }

  @override
  int get hashCode {
    return timestamp.hashCode ^
        description.hashCode ^
        activityUser.hashCode ^
        recieverUser.hashCode ^
        visibility.hashCode ^
        url.hashCode ^
        isSponsored.hashCode ^
        activityUid.hashCode ^
        likedBy.hashCode ^
        numOfComments.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        industry.hashCode ^
        userImagePath.hashCode;
  }
}
