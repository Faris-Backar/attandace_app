// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'staff_bloc.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();

  @override
  List<Object> get props => [];
}

class CreateStaffEvent extends StaffEvent {
  final Staff staff;
  final String password;
  const CreateStaffEvent({
    required this.staff,
    required this.password,
  });
  @override
  List<Object> get props => [staff];
}

class GetStaffEvent extends StaffEvent {}

class UpdateStaffEvent extends StaffEvent {
  final Staff staff;
  final String userName;
  const UpdateStaffEvent({
    required this.staff,
    required this.userName,
  });
  @override
  List<Object> get props => [staff, userName];
}

class DeleteStaffEvent extends StaffEvent {
  final Staff staff;
  const DeleteStaffEvent({
    required this.staff,
  });
  @override
  List<Object> get props => [staff];
}
