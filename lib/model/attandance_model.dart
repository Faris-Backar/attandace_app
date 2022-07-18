import 'dart:convert';

class Attandance {
  String date;
  bool isPresent;
  String courseName;
  String courseCode;
  Attandance({
    required this.date,
    required this.isPresent,
    required this.courseName,
    required this.courseCode,
  });

  Attandance copyWith({
    String? date,
    bool? isPresent,
    String? courseName,
    String? courseCode,
  }) {
    return Attandance(
      date: date ?? this.date,
      isPresent: isPresent ?? this.isPresent,
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'isPresent': isPresent,
      'courseName': courseName,
      'courseCode': courseCode,
    };
  }

  factory Attandance.fromMap(Map<String, dynamic> map) {
    return Attandance(
      date: map['date'] ?? '',
      isPresent: map['isPresent'] ?? false,
      courseName: map['courseName'] ?? '',
      courseCode: map['courseCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Attandance.fromJson(String source) =>
      Attandance.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attandance(date: $date, isPresent: $isPresent, courseName: $courseName, courseCode: $courseCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attandance &&
        other.date == date &&
        other.isPresent == isPresent &&
        other.courseName == courseName &&
        other.courseCode == courseCode;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        isPresent.hashCode ^
        courseName.hashCode ^
        courseCode.hashCode;
  }
}
