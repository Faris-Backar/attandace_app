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
  final String index;
  const UpdateStaffEvent({
    required this.staff,
    required this.index,
  });
  @override
  List<Object> get props => [staff, index];
}

class DeleteStaffEvent extends StaffEvent {
  final int index;
  const DeleteStaffEvent({
    required this.index,
  });
  @override
  List<Object> get props => [index];
}
