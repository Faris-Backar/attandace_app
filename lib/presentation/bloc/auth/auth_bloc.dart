import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_signInWithEmail);
    on<SignOutEvent>(_signout);
  }
  _signInWithEmail(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    emit(AuthLoading());
    try {
      final res = await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      final User user = res.user!;
      log(res.user!.uid);
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final response = await db.collection('user').doc(user.uid).get();
      log(response.toString());
      log('Role ${response['role']}');
      emit(AuthLoaded(role: response['role']));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: e.code));
    }
  }

  _signout(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    emit(AuthLoading());
    try {
      final response = await _auth.signOut();
      emit(AuthSigOutState());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: e.code));
    }
  }
}
