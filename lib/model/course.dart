import 'dart:convert';
import 'package:attandance_app/model/staff.dart';

class Course {
  String name;
  String courseCode;
  Staff? staff;
  String totalHoursTaken;
  Course({
    required this.name,
    required this.courseCode,
    this.staff,
    required this.totalHoursTaken,
  });

  Course copyWith({
    String? name,
    String? courseCode,
    Staff? staff,
    String? totalHoursTaken,
  }) {
    return Course(
      name: name ?? this.name,
      courseCode: courseCode ?? this.courseCode,
      staff: staff ?? this.staff,
      totalHoursTaken: totalHoursTaken ?? this.totalHoursTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'courseCode': courseCode,
      'staff': staff?.toMap(),
      'totalHoursTaken': totalHoursTaken,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] ?? '',
      courseCode: map['courseCode'] ?? '',
      staff: map['staff'] != null ? Staff.fromMap(map['staff']) : null,
      totalHoursTaken: map['totalHoursTaken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(name: $name, courseCode: $courseCode, staff: $staff, totalHoursTaken: $totalHoursTaken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.name == name &&
        other.courseCode == courseCode &&
        other.staff == staff &&
        other.totalHoursTaken == totalHoursTaken;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        courseCode.hashCode ^
        staff.hashCode ^
        totalHoursTaken.hashCode;
  }
}
