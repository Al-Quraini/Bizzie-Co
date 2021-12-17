import 'dart:convert';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:bizzie_co/data/models/user/social_link.dart';

enum CardTemplate {
  verticalHalf,
  horizontalHalf,
  halfWithImage,
  regular,
}

class UserCard {
  final String? website;
  final String mobilePhone;
  final String firstName;
  final String lastName;
  final String? workPhone;
  final String email;
  final String cardUid;
  final String userUid;
  final String? workAddress;
  final SocialLink? socialLink;
  final CardTemplate cardTemplate;
  final String? imageUrl;
  final String? primary;
  final String? secondary;
  final String proffession;
  final String? fontStyle;
  UserCard({
    this.website,
    this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.cardUid,
    required this.userUid,
    required this.mobilePhone,
    this.workPhone,
    required this.email,
    this.workAddress,
    this.socialLink,
    required this.cardTemplate,
    this.primary,
    this.secondary,
    required this.proffession,
    this.fontStyle,
  });

  UserCard copyWith({
    String? website,
    String? mobilePhone,
    String? workPhone,
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
    String? cardUid,
    String? userUid,
    String? workAddress,
    SocialLink? socialLink,
    CardTemplate? cardTemplate,
    String? primary,
    String? secondary,
    String? proffession,
    String? fontStyle,
  }) {
    return UserCard(
      website: website ?? this.website,
      imageUrl: imageUrl ?? this.imageUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      cardUid: cardUid ?? this.cardUid,
      userUid: userUid ?? this.userUid,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      workPhone: workPhone ?? this.workPhone,
      email: email ?? this.email,
      workAddress: workAddress ?? this.workAddress,
      socialLink: socialLink ?? this.socialLink,
      cardTemplate: cardTemplate ?? this.cardTemplate,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      proffession: proffession ?? this.proffession,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'website': website,
      'mobilePhone': mobilePhone,
      'imageUrl': imageUrl,
      'workPhone': workPhone,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'cardUid': cardUid,
      'userUid': userUid,
      'workAddress': workAddress,
      'socialLink': socialLink?.toMap(),
      'cardTemplate': EnumToString.convertToString(cardTemplate),
      'primary': primary,
      'secondary': secondary,
      'proffession': proffession,
      'fontStyle': fontStyle,
    };
  }

  factory UserCard.fromMap(Map<String, dynamic> map) {
    return UserCard(
      website: map['website'],
      mobilePhone: map['mobilePhone'] ?? '',
      workPhone: map['workPhone'],
      imageUrl: map['imageUrl'],
      cardUid: map['cardUid'],
      userUid: map['userUid'],
      email: map['email'] ?? '',
      workAddress: map['workAddress'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      socialLink: SocialLink.fromMap(map['socialLink'] ?? {}),
      cardTemplate:
          EnumToString.fromString(CardTemplate.values, map['cardTemplate']) ??
              CardTemplate.regular,
      primary: map['primary'] ?? '',
      secondary: map['secondary'] ?? '',
      proffession: map['proffession'] ?? '',
      fontStyle: map['fontStyle'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCard.fromJson(String source) =>
      UserCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserCard(website: $website, mobilePhone: $mobilePhone, workPhone: $workPhone, email: $email, workAddress: $workAddress, socialLink: $socialLink, cardTemplate: $cardTemplate, primary: $primary, secondary: $secondary, proffession: $proffession, fontStyle: $fontStyle)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserCard &&
        other.website == website &&
        other.mobilePhone == mobilePhone &&
        other.lastName == lastName &&
        other.firstName == firstName &&
        other.cardUid == cardUid &&
        other.userUid == userUid &&
        other.workPhone == workPhone &&
        other.email == email &&
        other.workAddress == workAddress &&
        other.socialLink == socialLink &&
        other.cardTemplate == cardTemplate &&
        other.imageUrl == imageUrl &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.proffession == proffession &&
        other.fontStyle == fontStyle;
  }

  @override
  int get hashCode {
    return website.hashCode ^
        mobilePhone.hashCode ^
        workPhone.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        cardUid.hashCode ^
        userUid.hashCode ^
        email.hashCode ^
        workAddress.hashCode ^
        socialLink.hashCode ^
        cardTemplate.hashCode ^
        imageUrl.hashCode ^
        primary.hashCode ^
        secondary.hashCode ^
        proffession.hashCode ^
        fontStyle.hashCode;
  }
}
