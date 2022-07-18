part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class CreateCourseEvent extends AdminEvent {
  final Course course;
  const CreateCourseEvent({
    required this.course,
  });
  @override
  List<Object> get props => [course];
}

class GetCourseEvent extends AdminEvent {}

class GetCourseAttandaceEvent extends AdminEvent {
  final String courseName;
  const GetCourseAttandaceEvent({
    required this.courseName,
  });
}

class DeleteCourse extends AdminEvent {}
