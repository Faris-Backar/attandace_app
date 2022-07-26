import 'dart:developer';

import 'package:attandance_app/core/resources/pref_resources.dart';
import 'package:attandance_app/main.dart';
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

      if (response.exists) {
        String username = response['name'];
        prefs.setString(PrefResources.USERNAME, username);
        String token = await res.user!.getIdToken();
        prefs.setString(PrefResources.TOKEN, token);
        prefs.setBool(PrefResources.IS_LOGGEDIN, true);
        prefs.setString(PrefResources.LOGGED_USER_ROLE, response['role']);
        log(response.toString());
        log('Role ${response['role']}');
        emit(AuthLoaded(role: response['role']));
      } else {
        emit(const AuthError(error: 'user-not found'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: e.code));
    }
  }

  _signout(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    emit(AuthLoading());
    try {
      await _auth.signOut();
      prefs.clear();
      emit(AuthSignOutStateLoaded());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: e.code));
    }
  }
}
