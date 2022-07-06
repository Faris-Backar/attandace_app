import 'dart:convert';

import 'package:attandance_app/model/staff.dart';

class Course {
  String name;
  String courseCode;
  Staff? staff;
  Course({
    required this.name,
    required this.courseCode,
    this.staff,
  });

  Course copyWith({
    String? name,
    String? courseCode,
    Staff? staff,
  }) {
    return Course(
      name: name ?? this.name,
      courseCode: courseCode ?? this.courseCode,
      staff: staff ?? this.staff,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'courseCode': courseCode,
      'staff': staff?.toMap(),
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] ?? '',
      courseCode: map['courseCode'] ?? '',
      staff: map['staff'] != null ? Staff.fromMap(map['staff']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() =>
      'Course(name: $name, courseCode: $courseCode, staff: $staff)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.name == name &&
        other.courseCode == courseCode &&
        other.staff == staff;
  }

  @override
  int get hashCode => name.hashCode ^ courseCode.hashCode ^ staff.hashCode;
}
