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
  List<Attandance>? attandaceList;
  Student({
    required this.name,
    required this.registrationNumber,
    required this.email,
    required this.password,
    required this.department,
    required this.year,
    required this.semester,
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
      attandaceList: attandaceList ?? this.attandaceList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'registrationNumber': registrationNumber,
      'email': email,
      'password': password,
      'department': department,
      'year': year,
      'semester': semester,
      'attandaceList': attandaceList?.map((x) => x.toMap()).toList(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] ?? '',
      registrationNumber: map['registrationNumber'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      department: map['department'] ?? '',
      year: map['year'] ?? '',
      semester: map['semester'] ?? '',
      attandaceList: map['attandaceList'] != null
          ? List<Attandance>.from(
              map['attandaceList']?.map((x) => Attandance.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(name: $name, registrationNumber: $registrationNumber, email: $email, password: $password, department: $department, year: $year, semester: $semester, attandaceList: $attandaceList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.name == name &&
        other.registrationNumber == registrationNumber &&
        other.email == email &&
        other.password == password &&
        other.department == department &&
        other.year == year &&
        other.semester == semester &&
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
        attandaceList.hashCode;
  }
}
