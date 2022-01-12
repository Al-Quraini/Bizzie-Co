import 'dart:convert';

class Report {
  final String reportedUser;
  final String reportedBy;
  final String description;
  final DateTime timestamp;
  final String reportUid;
  Report({
    required this.reportedUser,
    required this.reportedBy,
    required this.description,
    required this.timestamp,
    required this.reportUid,
  });

  Report copyWith({
    String? reportedUser,
    String? reportedBy,
    String? description,
    DateTime? timestamp,
    String? reportUid,
  }) {
    return Report(
      reportedUser: reportedUser ?? this.reportedUser,
      reportedBy: reportedBy ?? this.reportedBy,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      reportUid: reportUid ?? this.reportUid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reportedUser': reportedUser,
      'reportedBy': reportedBy,
      'description': description,
      'timestamp': timestamp,
      'reportUid': reportUid,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      reportedUser: map['reportedUser'] ?? '',
      reportedBy: map['reportedBy'] ?? '',
      description: map['description'] ?? '',
      timestamp: map['timestamp'].toDate(),
      reportUid: map['reportUid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Report(reportedUser: $reportedUser, reportedBy: $reportedBy, description: $description, timestamp: $timestamp, reportUid: $reportUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Report &&
        other.reportedUser == reportedUser &&
        other.reportedBy == reportedBy &&
        other.description == description &&
        other.timestamp == timestamp &&
        other.reportUid == reportUid;
  }

  @override
  int get hashCode {
    return reportedUser.hashCode ^
        reportedBy.hashCode ^
        description.hashCode ^
        timestamp.hashCode ^
        reportUid.hashCode;
  }
}
