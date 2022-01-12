import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:bizzie_co/data/models/user/education.dart';
import 'package:bizzie_co/data/models/user/experience.dart';
import 'package:bizzie_co/data/models/user/geo_location.dart';
import 'package:bizzie_co/data/models/user/social_link.dart';

class User {
  String? _imageUrl;

  set setUrl(String? url) {
    _imageUrl = url;
  }

  String? get userImage {
    return _imageUrl;
  }

  // Keys
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String email;
  final bool isPromoted;
  final String? imagePath;
  final String? aboutMe;
  final int numOfConnections;
  final int? ranking;
  final String? primaryCard;
  final SocialLink? socialLink;
  final GeoLocation? location;
  final String? industry;
  final DateTime timestamp;
  final Experience? experience;
  final Education? education;
  final List<String>? interests;
  final List<String>? skills;
  User({
    required this.uid,
    this.firstName,
    this.lastName,
    this.phone,
    required this.email,
    this.imagePath,
    this.aboutMe,
    required this.numOfConnections,
    this.ranking,
    this.primaryCard,
    this.socialLink,
    this.location,
    this.isPromoted = false,
    this.industry,
    required this.timestamp,
    this.experience,
    this.education,
    this.interests,
    this.skills,
  });

  User copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? imagePath,
    String? aboutMe,
    int? numOfConnections,
    int? ranking,
    bool? isPromoted,
    String? primaryCard,
    SocialLink? socialLink,
    GeoLocation? location,
    String? industry,
    DateTime? timestamp,
    Experience? experience,
    Education? education,
    List<String>? interests,
    List<String>? skills,
  }) {
    return User(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      aboutMe: aboutMe ?? this.aboutMe,
      numOfConnections: numOfConnections ?? this.numOfConnections,
      ranking: ranking ?? this.ranking,
      primaryCard: primaryCard ?? this.primaryCard,
      socialLink: socialLink ?? this.socialLink,
      location: location ?? this.location,
      isPromoted: isPromoted ?? this.isPromoted,
      industry: industry ?? this.industry,
      timestamp: timestamp ?? this.timestamp,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'imagePath': imagePath,
      'aboutMe': aboutMe,
      'numOfConnections': numOfConnections,
      'ranking': ranking,
      'isPromoted': isPromoted,
      'primaryCard': primaryCard,
      'socialLink': socialLink?.toMap(),
      'location': location?.toMap(),
      'industry': industry,
      'timestamp': timestamp,
      'experience': experience?.toMap(),
      'education': education?.toMap(),
      'interests': interests,
      'skills': skills,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      email: map['email'] ?? '',
      isPromoted: map['isPromoted'] ?? false,
      imagePath: map['imagePath'],
      aboutMe: map['aboutMe'],
      numOfConnections: map['numOfConnections']?.toInt() ?? 0,
      ranking: map['ranking']?.toInt(),
      primaryCard: map['primaryCard'],
      socialLink: map['socialLink'] != null
          ? SocialLink.fromMap(map['socialLink'])
          : null,
      location:
          map['location'] != null ? GeoLocation.fromMap(map['location']) : null,
      industry: map['industry'] ?? '',
      timestamp: map['timestamp'].toDate(),
      experience: map['experience'] != null
          ? Experience.fromMap(map['experience'])
          : null,
      education:
          map['education'] != null ? Education.fromMap(map['education']) : null,
      interests: List<String>.from(map['interests'] ?? []),
      skills: List<String>.from(map['skills'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, firstName: $firstName, lastName: $lastName, isPromoted: $isPromoted, phone: $phone, email: $email, imagePath: $imagePath, aboutMe: $aboutMe, numOfConnections: $numOfConnections, ranking: $ranking, primaryCard: $primaryCard, socialLink: $socialLink, location: $location, industry: $industry, timestamp: $timestamp, experience: $experience, education: $education, interests: $interests, skills: $skills)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.email == email &&
        other.imagePath == imagePath &&
        other.aboutMe == aboutMe &&
        other.isPromoted == isPromoted &&
        other.numOfConnections == numOfConnections &&
        other.ranking == ranking &&
        other.primaryCard == primaryCard &&
        other.socialLink == socialLink &&
        other.location == location &&
        other.industry == industry &&
        other.timestamp == timestamp &&
        other.experience == experience &&
        other.education == education &&
        listEquals(other.interests, interests) &&
        listEquals(other.skills, skills);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        imagePath.hashCode ^
        aboutMe.hashCode ^
        isPromoted.hashCode ^
        numOfConnections.hashCode ^
        ranking.hashCode ^
        primaryCard.hashCode ^
        socialLink.hashCode ^
        location.hashCode ^
        industry.hashCode ^
        timestamp.hashCode ^
        experience.hashCode ^
        education.hashCode ^
        interests.hashCode ^
        skills.hashCode;
  }
}

 /*  Tier get userTier {
    if (numOfConnections < 25) {
      return Tier.newbeem;
    } else if (numOfConnections < 100) {
      return Tier.workbee;
    } else if (numOfConnections < 500) {
      return Tier.bumblebee;
    } else if (numOfConnections < 2500) {
      return Tier.socialbee;
    } else {
      return Tier.queenbee;
    }
  } */
