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
  const MarkAttandanceEvent({
    required this.presentStudentsList,
    required this.attandance,
  });
  @override
  List<Object> get props => [presentStudentsList];
}

class GetIndividualCourseAttandanceEvent extends AttandanceEvent {
  final String studentName;
  final String courseName;
  const GetIndividualCourseAttandanceEvent({
    required this.studentName,
    required this.courseName,
  });
  @override
  List<Object> get props => [studentName, courseName];
}
