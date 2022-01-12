import 'dart:convert';

class Attendee {
  String? _imageUrl;

  set setUrl(String? url) {
    _imageUrl = url;
  }

  String? get userImage {
    return _imageUrl;
  }

  final String firstName;
  final String lastName;
  final String userUid;
  final String email;
  final String industry;
  final String? imagePath;
  final DateTime timestamp;
  Attendee({
    required this.firstName,
    required this.lastName,
    required this.userUid,
    required this.email,
    required this.industry,
    this.imagePath,
    required this.timestamp,
  });

  Attendee copyWith({
    String? firstName,
    String? lastName,
    String? userUid,
    String? email,
    String? industry,
    String? imagePath,
    DateTime? timestamp,
  }) {
    return Attendee(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userUid: userUid ?? this.userUid,
      email: email ?? this.email,
      industry: industry ?? this.industry,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userUid': userUid,
      'email': email,
      'industry': industry,
      'imagePath': imagePath,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Attendee.fromMap(Map<String, dynamic> map) {
    return Attendee(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      userUid: map['userUid'] ?? '',
      email: map['email'] ?? '',
      industry: map['industry'] ?? '',
      imagePath: map['imagePath'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendee.fromJson(String source) =>
      Attendee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attendee(firstName: $firstName, lastName: $lastName, userUid: $userUid, email: $email, industry: $industry, imagePath: $imagePath, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attendee &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userUid == userUid &&
        other.email == email &&
        other.industry == industry &&
        other.imagePath == imagePath &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        userUid.hashCode ^
        email.hashCode ^
        industry.hashCode ^
        imagePath.hashCode ^
        timestamp.hashCode;
  }
}
