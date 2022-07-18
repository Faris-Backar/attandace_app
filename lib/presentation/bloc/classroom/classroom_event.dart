part of 'classroom_bloc.dart';

abstract class ClassroomEvent extends Equatable {
  const ClassroomEvent();

  @override
  List<Object> get props => [];
}

class CreateClassRoomEvent extends ClassroomEvent {
  final ClassRoom classRoom;
  const CreateClassRoomEvent({
    required this.classRoom,
  });
  @override
  List<Object> get props => [classRoom];
}

class UpdateClassRoomEvent extends ClassroomEvent {
  final ClassRoom classRoom;
  final int index;
  const UpdateClassRoomEvent({
    required this.classRoom,
    required this.index,
  });
  @override
  List<Object> get props => [classRoom];
}

class DeleteClassRoomEvent extends ClassroomEvent {
  final ClassRoom classRoom;
  final int index;
  const DeleteClassRoomEvent({
    required this.classRoom,
    required this.index,
  });
  @override
  List<Object> get props => [classRoom];
}

class GetClassRoomEvent extends ClassroomEvent {}

class AddClassRoomStudentsEvent extends ClassroomEvent {
  final List<Student> studentsList;
  const AddClassRoomStudentsEvent({
    required this.studentsList,
  });
  @override
  List<Object> get props => [studentsList];
}

class GetClassRoomStudentsEvent extends ClassroomEvent {}

class DeleteClassRoomStudentsEvent extends ClassroomEvent {
  final Course course;
  const DeleteClassRoomStudentsEvent({
    required this.course,
  });
  @override
  List<Object> get props => [course];
}
