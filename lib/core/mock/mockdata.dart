import 'package:attandance_app/model/attandance_model.dart';

class MockData {
  static List<Attandance> attandanceList = List.generate(
    30,
    (index) => Attandance(
        date: DateTime.now().add(const Duration(days: 1)).toString(),
        isPresent: index % 2 == 0 ? true : false,
        courseName: 'Engineering Maths',
        courseCode: 'MA201'),
  );
}
