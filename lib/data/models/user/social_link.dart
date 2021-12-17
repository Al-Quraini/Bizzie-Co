import 'dart:convert';

class SocialLink {
  final String? instagram;
  final String? facebook;
  final String? linkedin;
  final String? tiktok;
  final String? snapshat;
  SocialLink({
    this.instagram,
    this.facebook,
    this.linkedin,
    this.tiktok,
    this.snapshat,
  });

  SocialLink copyWith({
    String? instagram,
    String? facebook,
    String? linkedin,
    String? tiktok,
    String? snapshat,
  }) {
    return SocialLink(
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      linkedin: linkedin ?? this.linkedin,
      tiktok: tiktok ?? this.tiktok,
      snapshat: snapshat ?? this.snapshat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'instagram': instagram,
      'facebook': facebook,
      'linkedin': linkedin,
      'tiktok': tiktok,
      'snapshat': snapshat,
    };
  }

  factory SocialLink.fromMap(Map<String, dynamic> map) {
    return SocialLink(
      instagram: map['instagram'],
      facebook: map['facebook'],
      linkedin: map['linkedin'],
      tiktok: map['tiktok'],
      snapshat: map['snapshat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialLink.fromJson(String source) =>
      SocialLink.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SocialLink(instagram: $instagram, facebook: $facebook, linkedin: $linkedin, tiktok: $tiktok, snapshat: $snapshat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SocialLink &&
        other.instagram == instagram &&
        other.facebook == facebook &&
        other.linkedin == linkedin &&
        other.tiktok == tiktok &&
        other.snapshat == snapshat;
  }

  @override
  int get hashCode {
    return instagram.hashCode ^
        facebook.hashCode ^
        linkedin.hashCode ^
        tiktok.hashCode ^
        snapshat.hashCode;
  }
}
