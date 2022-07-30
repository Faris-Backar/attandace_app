// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'attandance_bloc.dart';

abstract class AttandanceEvent extends Equatable {
  const AttandanceEvent();

  @override
  List<Object> get props => [];
}

class MarkAttandanceEvent extends AttandanceEvent {
  final List<Student> presentStudentsList;
  final Attandance attandance;
  final Course course;
  final ClassRoom classroom;
  final List<Students> studentsList;
  final ClassAttandanceModel classAttandanceModel;
  const MarkAttandanceEvent({
    required this.presentStudentsList,
    required this.attandance,
    required this.classroom,
    required this.course,
    required this.studentsList,
    required this.classAttandanceModel,
  });
  @override
  List<Object> get props => [presentStudentsList];
}

class GetIndividualCourseAttandanceEvent extends AttandanceEvent {
  final String courseName;
  final String date;
  final String className;
  const GetIndividualCourseAttandanceEvent({
    required this.courseName,
    required this.date,
    required this.className,
  });
  @override
  List<Object> get props => [courseName, date, className];
}

class CheckStudentIsUnder extends AttandanceEvent {
  final String date;
  final String classAssigned;
  const CheckStudentIsUnder({
    required this.date,
    required this.classAssigned,
  });
}
