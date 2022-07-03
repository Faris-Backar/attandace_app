part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {}

class CreateStaffLoading extends AdminState {}

class CreateStaffLoaded extends AdminState {}

class GetStaffLoading extends AdminState {}

class GetStaffLoaded extends AdminState {
  final List<Staff> staffList;
  const GetStaffLoaded({
    required this.staffList,
  });
  @override
  List<Object> get props => [staffList];
}

class GetCourseLoading extends AdminState {}

class GetCourseLoaded extends AdminState {
  final List<Course> courseList;
  const GetCourseLoaded({
    required this.courseList,
  });
  @override
  List<Object> get props => [courseList];
}

class AdminError extends AdminState {}
