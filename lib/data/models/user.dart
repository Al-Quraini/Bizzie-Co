import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bizzie_co/data/models/user/education.dart';
import 'package:bizzie_co/data/models/user/experience.dart';
import 'package:bizzie_co/data/models/user/geo_location.dart';
import 'package:bizzie_co/data/models/user/social_link.dart';

enum Tier { newbeem, workbee, bumblebee, socialbee, queenbee }

class User {
  Tier get userTier {
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
  }

  // Keys
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String email;
  final String? imageUrl;
  final String? aboutMe;
  final int numOfConnections;
  final String? primaryCard;
  final SocialLink? socialLink;
  final GeoLocation? location;
  final String? occupation;
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
    this.imageUrl,
    this.aboutMe,
    required this.numOfConnections,
    this.primaryCard,
    this.socialLink,
    this.location,
    this.occupation,
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
    String? imageUrl,
    String? aboutMe,
    int? numOfConnections,
    String? primaryCard,
    SocialLink? socialLink,
    GeoLocation? location,
    String? occupation,
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
      imageUrl: imageUrl ?? this.imageUrl,
      aboutMe: aboutMe ?? this.aboutMe,
      numOfConnections: numOfConnections ?? this.numOfConnections,
      primaryCard: primaryCard ?? this.primaryCard,
      socialLink: socialLink ?? this.socialLink,
      location: location ?? this.location,
      occupation: occupation ?? this.occupation,
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
      'imageUrl': imageUrl,
      'aboutMe': aboutMe,
      'numOfConnections': numOfConnections,
      'primaryCard': primaryCard,
      'socialLink': socialLink?.toMap(),
      'location': location?.toMap(),
      'occupation': occupation,
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
      imageUrl: map['imageUrl'],
      aboutMe: map['aboutMe'],
      numOfConnections: map['numOfConnections']?.toInt() ?? 0,
      primaryCard: map['primaryCard'],
      socialLink: map['socialLink'] != null
          ? SocialLink.fromMap(map['socialLink'])
          : null,
      location:
          map['location'] != null ? GeoLocation.fromMap(map['location']) : null,
      occupation: map['occupation'],
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
    return 'User(uid: $uid, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, imageUrl: $imageUrl, aboutMe: $aboutMe, numOfConnections: $numOfConnections, primaryCard: $primaryCard, socialLink: $socialLink, location: $location, occupation: $occupation, experience: $experience, education: $education, interests: $interests, skills: $skills)';
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
        other.imageUrl == imageUrl &&
        other.aboutMe == aboutMe &&
        other.numOfConnections == numOfConnections &&
        other.primaryCard == primaryCard &&
        other.socialLink == socialLink &&
        other.location == location &&
        other.occupation == occupation &&
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
        imageUrl.hashCode ^
        aboutMe.hashCode ^
        numOfConnections.hashCode ^
        primaryCard.hashCode ^
        socialLink.hashCode ^
        location.hashCode ^
        occupation.hashCode ^
        experience.hashCode ^
        education.hashCode ^
        interests.hashCode ^
        skills.hashCode;
  }
}
