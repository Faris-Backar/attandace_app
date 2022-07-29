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

class GetCourseEvent extends AdminEvent {
  final String? className;
  final String? courseName;

  const GetCourseEvent({
    this.className,
    this.courseName,
  });
}

class GetCourseAttandaceEvent extends AdminEvent {
  final String courseName;
  final String className;
  const GetCourseAttandaceEvent({
    required this.courseName,
    required this.className,
  });
}

class DeleteCourse extends AdminEvent {}
