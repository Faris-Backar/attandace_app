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
  const UpdateStudentEvent({
    required this.student,
    required this.index,
  });
  @override
  List<Object> get props => [student, index];
}

class DeleteStudentEvent extends StudentEvent {
  final int index;
  const DeleteStudentEvent({
    required this.index,
  });
  @override
  List<Object> get props => [index];
}
