part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class CreateStudentLoaded extends StudentState {}

class GetStudentLoaded extends StudentState {
  final List<Student> studentList;
  const GetStudentLoaded({
    required this.studentList,
  });
  @override
  List<Object> get props => [studentList];
}

class StudentError extends StudentState {
  final String error;
  const StudentError({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
