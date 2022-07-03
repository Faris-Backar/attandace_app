import 'dart:convert';

class Course {
  String name;
  String courseCode;
  Course({
    required this.name,
    required this.courseCode,
  });

  Course copyWith({
    String? name,
    String? courseCode,
  }) {
    return Course(
      name: name ?? this.name,
      courseCode: courseCode ?? this.courseCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'courseCode': courseCode,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] ?? '',
      courseCode: map['courseCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() => 'Course(name: $name, courseCode: $courseCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.name == name &&
        other.courseCode == courseCode;
  }

  @override
  int get hashCode => name.hashCode ^ courseCode.hashCode;
}
