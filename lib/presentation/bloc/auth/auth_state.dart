part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final String role;
  const AuthLoaded({
    required this.role,
  });
  @override
  List<Object> get props => [role];
}

class AuthError extends AuthState {
  final String error;
  const AuthError({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class AuthSigOutState extends AuthState {}
