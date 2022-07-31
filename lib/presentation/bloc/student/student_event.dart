// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class CreateStudentEvent extends StudentEvent {
  final Student student;
  final String password;
  const CreateStudentEvent({
    required this.student,
    required this.password,
  });
  @override
  List<Object> get props => [student];
}

class GetStudentEvent extends StudentEvent {}

class UpdateStudentEvent extends StudentEvent {
  final Student student;
  final int index;
  final String name;
  const UpdateStudentEvent({
    required this.student,
    required this.index,
    required this.name,
  });
  @override
  List<Object> get props => [student, index];
}

class DeleteStudentEvent extends StudentEvent {
  final String username;
  final String? uid;
  const DeleteStudentEvent({
    required this.username,
    required this.uid,
  });
  @override
  List<Object> get props => [username];
}

class GetFilteredStudentsAccordingtoSemester extends StudentEvent {
  final String semester;
  final String branch;
  const GetFilteredStudentsAccordingtoSemester({
    required this.semester,
    required this.branch,
  });

  @override
  List<Object> get props => [semester, branch];
}

class DeleteFilteredStudentsAccordingtoSemester extends StudentEvent {
  final Student student;
  const DeleteFilteredStudentsAccordingtoSemester({
    required this.student,
  });

  @override
  List<Object> get props => [student];
}

class GetIndividualStudentEvent extends StudentEvent {
  final String userName;
  const GetIndividualStudentEvent({
    required this.userName,
  });
  @override
  List<Object> get props => [userName];
}
