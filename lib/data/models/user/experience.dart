import 'dart:convert';

import 'package:bizzie_co/data/models/user/geo_location.dart';

class Experience {
  final String? institution;
  final String? profession;
  final String? field;
  final DateTime? startDate;
  final DateTime? endDate;
  final GeoLocation? location;
  final String? description;
  final bool isPresent;
  Experience({
    this.institution,
    this.profession,
    this.field,
    this.startDate,
    this.endDate,
    this.location,
    this.description,
    this.isPresent = false,
  });

  Experience copyWith({
    String? institution,
    String? profession,
    String? field,
    DateTime? startDate,
    DateTime? endDate,
    GeoLocation? location,
    String? description,
    bool? isPresent,
  }) {
    return Experience(
      institution: institution ?? this.institution,
      profession: profession ?? this.profession,
      field: field ?? this.field,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      description: description ?? this.description,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institution': institution,
      'profession': profession,
      'field': field,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'location': location?.toMap(),
      'description': description,
      'isPresent': isPresent,
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      institution: map['institution'],
      profession: map['profession'],
      field: map['field'],
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
          : null,
      location:
          map['location'] != null ? GeoLocation.fromMap(map['location']) : null,
      description: map['description'],
      isPresent: map['isPresent'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Experience.fromJson(String source) =>
      Experience.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Experience(institution: $institution, profession: $profession, field: $field, startDate: $startDate, endDate: $endDate, location: $location, description: $description, isPresent: $isPresent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Experience &&
        other.institution == institution &&
        other.profession == profession &&
        other.field == field &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.location == location &&
        other.description == description &&
        other.isPresent == isPresent;
  }

  @override
  int get hashCode {
    return institution.hashCode ^
        profession.hashCode ^
        field.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        location.hashCode ^
        description.hashCode ^
        isPresent.hashCode;
  }
}
