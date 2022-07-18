part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {}

class GetCourseLoading extends AdminState {}

class GetCourseLoaded extends AdminState {
  final List<Course> courseList;
  final List<CourseAttandance>? courseAttandace;
  const GetCourseLoaded({
    required this.courseList,
    this.courseAttandace,
  });
  @override
  List<Object> get props => [courseList];
}

class GetCourseAttandanceLoaded extends AdminState {
  final List<CourseAttandance> courseAttandace;
  const GetCourseAttandanceLoaded({
    required this.courseAttandace,
  });
  @override
  List<Object> get props => [courseAttandace];
}

class AdminError extends AdminState {
  final String error;
  const AdminError({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
