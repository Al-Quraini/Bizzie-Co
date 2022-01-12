import 'dart:convert';

class LocationModel {
  final double lat;
  final double lng;
  final String city;
  final String state;
  final String country;
  final String? street;
  final String? place;
  LocationModel({
    required this.lat,
    required this.lng,
    required this.city,
    required this.state,
    required this.country,
    this.street,
    this.place,
  });

  LocationModel copyWith({
    double? lat,
    double? lng,
    String? city,
    String? state,
    String? country,
    String? street,
    String? place,
  }) {
    return LocationModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      street: street ?? this.street,
      place: place ?? this.place,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'city': city,
      'state': state,
      'country': country,
      'street': street,
      'place': place,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      street: map['street'],
      place: map['place'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationModel(lat: $lat, lng: $lng, city: $city, state: $state, country: $country, street: $street, place: $place)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LocationModel &&
      other.lat == lat &&
      other.lng == lng &&
      other.city == city &&
      other.state == state &&
      other.country == country &&
      other.street == street &&
      other.place == place;
  }

  @override
  int get hashCode {
    return lat.hashCode ^
      lng.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      street.hashCode ^
      place.hashCode;
  }
}
