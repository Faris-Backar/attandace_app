part of 'attandance_bloc.dart';

abstract class AttandanceState extends Equatable {
  const AttandanceState();

  @override
  List<Object> get props => [];
}

class AttandanceInitial extends AttandanceState {}

class AttandanceLoading extends AttandanceState {}

class MarkAttandanceLoaded extends AttandanceState {}

class AttandanceLoaded extends AttandanceState {
  final List<Attandance> attandance;
  const AttandanceLoaded({
    required this.attandance,
  });
  @override
  List<Object> get props => [attandance];
}

class IndividualCourseAttandanceLoaded extends AttandanceState {
  final ClassAttandanceModel classAttandance;
  const IndividualCourseAttandanceLoaded({
    required this.classAttandance,
  });
}

class AttandanceError extends AttandanceState {
  final String error;
  const AttandanceError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
