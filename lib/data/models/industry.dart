import 'dart:convert';

class Industry {
  final String industryId;
  final int numOfUsers;
  final String? description;
  Industry({
    required this.industryId,
    required this.numOfUsers,
    this.description,
  });

  Industry copyWith({
    String? industryId,
    int? numOfUsers,
    String? description,
  }) {
    return Industry(
      industryId: industryId ?? this.industryId,
      numOfUsers: numOfUsers ?? this.numOfUsers,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'industryId': industryId,
      'numOfUsers': numOfUsers,
      'description': description,
    };
  }

  factory Industry.fromMap(Map<String, dynamic> map) {
    return Industry(
      industryId: map['industryId'] ?? '',
      numOfUsers: map['numOfUsers']?.toInt() ?? 0,
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Industry.fromJson(String source) =>
      Industry.fromMap(json.decode(source));

  @override
  String toString() =>
      'Industry(industryId: $industryId, numOfUsers: $numOfUsers, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Industry &&
        other.industryId == industryId &&
        other.numOfUsers == numOfUsers &&
        other.description == description;
  }

  @override
  int get hashCode =>
      industryId.hashCode ^ numOfUsers.hashCode ^ description.hashCode;
}
