part of 'staff_bloc.dart';

abstract class StaffState extends Equatable {
  const StaffState();

  @override
  List<Object> get props => [];
}

class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class CreateStaffLoaded extends StaffState {}

class GetStaffLoaded extends StaffState {
  final List<Staff> staffList;
  const GetStaffLoaded({
    required this.staffList,
  });
  @override
  List<Object> get props => [staffList];
}

class StaffError extends StaffState {
  final String error;
  const StaffError({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
