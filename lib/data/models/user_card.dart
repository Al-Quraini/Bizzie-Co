import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:bizzie_co/utils/enums.dart';

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
  final String? company;
  final CardTemplate cardTemplate;

  final Color primary;
  final Color secondary;
  final Color textColor;
  final Color secondaryTextColor;
  final String position;
  UserCard({
    this.website,
    required this.mobilePhone,
    required this.firstName,
    required this.lastName,
    this.workPhone,
    required this.email,
    required this.cardUid,
    required this.userUid,
    this.workAddress,
    this.company,
    required this.cardTemplate,
    required this.primary,
    required this.secondary,
    required this.textColor,
    required this.secondaryTextColor,
    required this.position,
  });

  UserCard copyWith({
    String? website,
    String? mobilePhone,
    String? firstName,
    String? lastName,
    String? workPhone,
    String? email,
    String? cardUid,
    String? userUid,
    String? company,
    String? workAddress,
    CardTemplate? cardTemplate,
    Color? primary,
    Color? secondary,
    Color? textColor,
    Color? secondaryTextColor,
    String? position,
  }) {
    return UserCard(
      website: website ?? this.website,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      workPhone: workPhone ?? this.workPhone,
      email: email ?? this.email,
      cardUid: cardUid ?? this.cardUid,
      company: company ?? this.company,
      userUid: userUid ?? this.userUid,
      workAddress: workAddress ?? this.workAddress,
      cardTemplate: cardTemplate ?? this.cardTemplate,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'website': website,
      'mobilePhone': mobilePhone,
      'firstName': firstName,
      'lastName': lastName,
      'workPhone': workPhone,
      'email': email,
      'company': company,
      'cardUid': cardUid,
      'userUid': userUid,
      'workAddress': workAddress,
      'cardTemplate': EnumToString.convertToString(cardTemplate),
      'primary': primary.value,
      'secondary': secondary.value,
      'textColor': textColor.value,
      'secondaryTextColor': secondaryTextColor.value,
      'position': position,
    };
  }

  factory UserCard.fromMap(Map<String, dynamic> map) {
    return UserCard(
      website: map['website'],
      company: map['company'],
      mobilePhone: map['mobilePhone'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      workPhone: map['workPhone'],
      email: map['email'] ?? '',
      cardUid: map['cardUid'] ?? '',
      userUid: map['userUid'] ?? '',
      workAddress: map['workAddress'],
      cardTemplate:
          EnumToString.fromString(CardTemplate.values, map['cardTemplate']) ??
              CardTemplate.regular,
      primary: Color(map['primary']),
      secondary: Color(map['secondary']),
      textColor: Color(map['textColor']),
      secondaryTextColor: Color(map['secondaryTextColor']),
      position: map['position'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCard.fromJson(String source) =>
      UserCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserCard(website: $website, mobilePhone: $mobilePhone, firstName: $firstName, lastName: $lastName, workPhone: $workPhone, email: $email, cardUid: $cardUid, userUid: $userUid, workAddress: $workAddress, cardTemplate: $cardTemplate, primary: $primary, secondary: $secondary, textColor: $textColor, secondaryTextColor: $secondaryTextColor, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserCard &&
        other.website == website &&
        other.mobilePhone == mobilePhone &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.workPhone == workPhone &&
        other.email == email &&
        other.company == company &&
        other.cardUid == cardUid &&
        other.userUid == userUid &&
        other.workAddress == workAddress &&
        other.cardTemplate == cardTemplate &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.textColor == textColor &&
        other.secondaryTextColor == secondaryTextColor &&
        other.position == position;
  }

  @override
  int get hashCode {
    return website.hashCode ^
        mobilePhone.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        workPhone.hashCode ^
        company.hashCode ^
        email.hashCode ^
        cardUid.hashCode ^
        userUid.hashCode ^
        workAddress.hashCode ^
        cardTemplate.hashCode ^
        primary.hashCode ^
        secondary.hashCode ^
        textColor.hashCode ^
        secondaryTextColor.hashCode ^
        position.hashCode;
  }
}
