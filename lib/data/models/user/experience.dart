import 'dart:convert';

import 'package:bizzie_co/data/models/user/geo_location.dart';

class Experience {
  final String position;
  final String job;
  final String startYear;
  final String? endYear;
  final GeoLocation location;
  final String description;
  final bool isPresent;
  Experience({
    required this.position,
    required this.job,
    required this.startYear,
    this.endYear,
    required this.location,
    required this.description,
    this.isPresent = false,
  });

  Experience copyWith({
    String? position,
    String? job,
    String? startYear,
    String? endYear,
    GeoLocation? location,
    String? description,
    bool? isPresent,
  }) {
    return Experience(
      position: position ?? this.position,
      job: job ?? this.job,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      location: location ?? this.location,
      description: description ?? this.description,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'job': job,
      'startYear': startYear,
      'endYear': endYear,
      'location': location.toMap(),
      'description': description,
      'isPresent': isPresent,
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      position: map['position'],
      job: map['job'],
      startYear: map['startYear'],
      endYear: map['endYear'],
      location: GeoLocation.fromMap(map['location']),
      description: map['description'],
      isPresent: map['isPresent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Experience.fromJson(String source) =>
      Experience.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Experience(position: $position, job: $job, startYear: $startYear, endYear: $endYear, location: $location, description: $description, isPresent: $isPresent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Experience &&
        other.position == position &&
        other.job == job &&
        other.startYear == startYear &&
        other.endYear == endYear &&
        other.location == location &&
        other.description == description &&
        other.isPresent == isPresent;
  }

  @override
  int get hashCode {
    return position.hashCode ^
        job.hashCode ^
        startYear.hashCode ^
        endYear.hashCode ^
        location.hashCode ^
        description.hashCode ^
        isPresent.hashCode;
  }
}
