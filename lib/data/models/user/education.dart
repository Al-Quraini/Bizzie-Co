import 'dart:convert';

import 'package:bizzie_co/data/models/user/geo_location.dart';

class Education {
  final String university;
  final String major;
  final int startYear;
  final int? endYear;
  final String? description;
  final GeoLocation location;
  final bool isPresent;
  Education({
    required this.university,
    required this.major,
    required this.startYear,
    this.endYear,
    this.description,
    required this.location,
    required this.isPresent,
  });

  Education copyWith({
    String? university,
    String? major,
    int? startYear,
    int? endYear,
    String? description,
    GeoLocation? location,
    bool? isPresent,
  }) {
    return Education(
      university: university ?? this.university,
      major: major ?? this.major,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      description: description ?? this.description,
      location: location ?? this.location,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'university': university,
      'major': major,
      'startYear': startYear,
      'endYear': endYear,
      'description': description,
      'location': location.toMap(),
      'isPresent': isPresent,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      university: map['university'],
      major: map['major'],
      startYear: map['startYear'],
      endYear: map['endYear'],
      description: map['description'],
      location: GeoLocation.fromMap(map['location']),
      isPresent: map['isPresent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Education.fromJson(String source) =>
      Education.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Education(university: $university, major: $major, startYear: $startYear, endYear: $endYear, description: $description, location: $location, isPresent: $isPresent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Education &&
        other.university == university &&
        other.major == major &&
        other.startYear == startYear &&
        other.endYear == endYear &&
        other.description == description &&
        other.location == location &&
        other.isPresent == isPresent;
  }

  @override
  int get hashCode {
    return university.hashCode ^
        major.hashCode ^
        startYear.hashCode ^
        endYear.hashCode ^
        description.hashCode ^
        location.hashCode ^
        isPresent.hashCode;
  }
}
