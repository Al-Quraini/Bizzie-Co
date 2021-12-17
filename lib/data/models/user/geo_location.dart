import 'dart:convert';

class GeoLocation {
  final String? city;
  final String? state;
  final String? country;
  GeoLocation({
    this.city,
    this.state,
    this.country,
  });

  GeoLocation copyWith({
    String? city,
    String? state,
    String? country,
  }) {
    return GeoLocation(
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'state': state,
      'country': country,
    };
  }

  factory GeoLocation.fromMap(Map<String, dynamic> map) {
    return GeoLocation(
      city: map['city'],
      state: map['state'],
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoLocation.fromJson(String source) =>
      GeoLocation.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserLocation(city: $city, state: $state, country: $country)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeoLocation &&
        other.city == city &&
        other.state == state &&
        other.country == country;
  }

  @override
  int get hashCode => city.hashCode ^ state.hashCode ^ country.hashCode;
}
