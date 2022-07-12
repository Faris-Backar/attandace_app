import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:attandance_app/model/attandance_model.dart';
import 'package:attandance_app/model/course.dart';

class Student {
  String name;
  String registrationNumber;
  String email;
  String password;
  String department;
  String year;
  String semester;
  List<Course>? courses;
  List<Attandance>? attandaceList;
  Student({
    required this.name,
    required this.registrationNumber,
    required this.email,
    required this.password,
    required this.department,
    required this.year,
    required this.semester,
    this.courses,
    this.attandaceList,
  });

  Student copyWith({
    String? name,
    String? registrationNumber,
    String? email,
    String? password,
    String? department,
    String? year,
    String? semester,
    List<Course>? courses,
    List<Attandance>? attandaceList,
  }) {
    return Student(
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      department: department ?? this.department,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      courses: courses ?? this.courses,
      attandaceList: attandaceList ?? this.attandaceList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'registrationNumber': registrationNumber,
      'email': email,
      'password': password,
      'department': department,
      'year': year,
      'semester': semester,
      'courses': courses!.map((x) => x.toMap()).toList(),
      'attandaceList': attandaceList!.map((x) => x.toMap()).toList(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] as String,
      registrationNumber: map['registrationNumber'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      department: map['department'] as String,
      year: map['year'] as String,
      semester: map['semester'] as String,
      courses: map['courses'] != null
          ? List<Course>.from(
              (map['courses'] as List<int>).map<Course?>(
                (x) => Course.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      attandaceList: map['attandaceList'] != null
          ? List<Attandance>.from(
              (map['attandaceList'] as List<int>).map<Attandance?>(
                (x) => Attandance.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(name: $name, registrationNumber: $registrationNumber, email: $email, password: $password, department: $department, year: $year, semester: $semester, courses: $courses, attandaceList: $attandaceList)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.registrationNumber == registrationNumber &&
        other.email == email &&
        other.password == password &&
        other.department == department &&
        other.year == year &&
        other.semester == semester &&
        listEquals(other.courses, courses) &&
        listEquals(other.attandaceList, attandaceList);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        registrationNumber.hashCode ^
        email.hashCode ^
        password.hashCode ^
        department.hashCode ^
        year.hashCode ^
        semester.hashCode ^
        courses.hashCode ^
        attandaceList.hashCode;
  }
}
