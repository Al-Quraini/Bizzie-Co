import 'dart:convert';

import 'package:bizzie_co/data/models/user/geo_location.dart';

class Education {
  final String? institution;
  final String? degree;
  final String? field;
  final DateTime? startDate;
  final DateTime? endDate;
  final GeoLocation? location;
  final String? description;
  final bool isPresent;
  Education({
    this.institution,
    this.degree,
    this.field,
    this.startDate,
    this.endDate,
    this.location,
    this.description,
    this.isPresent = false,
  });

  Education copyWith({
    String? institution,
    String? degree,
    String? field,
    DateTime? startDate,
    DateTime? endDate,
    GeoLocation? location,
    String? description,
    bool? isPresent,
  }) {
    return Education(
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
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
      'degree': degree,
      'field': field,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'location': location?.toMap(),
      'description': description,
      'isPresent': isPresent,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      institution: map['institution'] ?? '',
      degree: map['degree'] ?? '',
      field: map['field'] ?? '',
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

  factory Education.fromJson(String source) =>
      Education.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Education(institution: $institution, degree: $degree, field: $field, startDate: $startDate, endDate: $endDate, location: $location, description: $description, isPresent: $isPresent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Education &&
        other.institution == institution &&
        other.degree == degree &&
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
        degree.hashCode ^
        field.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        location.hashCode ^
        description.hashCode ^
        isPresent.hashCode;
  }
}
