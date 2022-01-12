import 'dart:convert';

class IndustryUser {
  String? _imageUrl;

  set setUrl(String? url) {
    _imageUrl = url;
  }

  String? get userImage {
    return _imageUrl;
  }

  final String firstName;
  final String lastName;
  final String? imagePath;
  final String industry;
  final String uid;
  IndustryUser({
    required this.firstName,
    required this.lastName,
    this.imagePath,
    required this.industry,
    required this.uid,
  });

  IndustryUser copyWith({
    String? firstName,
    String? lastName,
    String? imagePath,
    String? industry,
    String? uid,
  }) {
    return IndustryUser(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imagePath: imagePath ?? this.imagePath,
      industry: industry ?? this.industry,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'imagePath': imagePath,
      'industry': industry,
      'uid': uid,
    };
  }

  factory IndustryUser.fromMap(Map<String, dynamic> map) {
    return IndustryUser(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      imagePath: map['imagePath'],
      industry: map['industry'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IndustryUser.fromJson(String source) =>
      IndustryUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IndustryUser(firstName: $firstName, lastName: $lastName, imagePath: $imagePath, industry: $industry, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IndustryUser &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.imagePath == imagePath &&
        other.industry == industry &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        imagePath.hashCode ^
        industry.hashCode ^
        uid.hashCode;
  }
}
