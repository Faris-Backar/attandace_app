part of 'classroom_bloc.dart';

abstract class ClassroomState extends Equatable {
  const ClassroomState();

  @override
  List<Object> get props => [];
}

class ClassroomInitial extends ClassroomState {}

class ClassroomLoading extends ClassroomState {}

class CreateClassroomLoaded extends ClassroomState {}

class UpdateClassRoomLoaded extends ClassroomState {}

class DeleteClassRoomLoaded extends ClassroomState {}

class ClassRoomLoaded extends ClassroomState {
  final List<ClassRoom> classroomList;
  const ClassRoomLoaded({
    required this.classroomList,
  });
  @override
  List<Object> get props => [classroomList];
}

class ClassRoomError extends ClassroomState {
  final String error;
  const ClassRoomError({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class GetClassRoomStudents extends ClassroomState {
  final List<Student> studentList;
  const GetClassRoomStudents({
    required this.studentList,
  });
  @override
  List<Object> get props => [studentList];
}
