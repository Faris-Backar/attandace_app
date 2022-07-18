import 'dart:convert';

class CourseAttandance {
  final String dateTime;
  CourseAttandance({
    required this.dateTime,
  });

  CourseAttandance copyWith({
    String? dateTime,
  }) {
    return CourseAttandance(
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
    };
  }

  factory CourseAttandance.fromMap(Map<String, dynamic> map) {
    return CourseAttandance(
      dateTime: map['dateTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseAttandance.fromJson(String source) =>
      CourseAttandance.fromMap(json.decode(source));

  @override
  String toString() => 'CourseAttandance(dateTime: $dateTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseAttandance && other.dateTime == dateTime;
  }

  @override
  int get hashCode => dateTime.hashCode;
}
