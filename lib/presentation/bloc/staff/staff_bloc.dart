import 'dart:developer';

import 'package:attandance_app/model/staff.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  List<Staff> staffList = [];
  final _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StaffBloc() : super(StaffInitial()) {
    on<CreateStaffEvent>(_createStaff);
    on<GetStaffEvent>(_getStaff);
    on<DeleteStaffEvent>(_deleteStaff);
    on<UpdateStaffEvent>(_updateStaff);
  }

  _createStaff(CreateStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffInitial());
    emit(StaffLoading());
    final _auth = FirebaseAuth.instance;
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: event.staff.email, password: event.password);
      final addUserInfo =
          await _firebaseFirestore.collection('user').doc(res.user!.uid).set({
        'name': event.staff.name,
        'role': 'staff',
      });
      try {
        final response = await _firebaseFirestore
            .collection('staff')
            .doc(event.staff.name)
            .set(event.staff.toMap());
      } on FirebaseException catch (e) {
        StaffError(error: e.code);
      }
      emit(CreateStaffLoaded());
    } on FirebaseAuthException catch (e) {
      emit(StaffError(error: e.code));
    }
    emit(CreateStaffLoaded());
  }

  _getStaff(GetStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffInitial());
    emit(StaffLoading());
    try {
      final response = await _firebaseFirestore.collection('staff').get();
      final res = response.docs
          .map((docSnap) => Staff.fromMap(docSnap.data()))
          .toList();
      staffList = res;
      emit(GetStaffLoaded(staffList: staffList));
    } on FirebaseException catch (e) {
      emit(StaffError(error: e.code));
    }
    emit(GetStaffLoaded(staffList: staffList));
  }

  _deleteStaff(DeleteStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffInitial());
    emit(StaffLoading());
    try {
      await _firebaseFirestore
          .collection('staff')
          .doc(event.staff.name)
          .delete();
      emit(DeleteStaffLoaded());
    } catch (e) {
      print(e.toString());
      emit(
        StaffError(
          error: e.toString(),
        ),
      );
    }
  }

  _updateStaff(UpdateStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffInitial());
    emit(StaffLoading());
    try {
      await _firebaseFirestore
          .collection('staff')
          .doc(event.staff.name)
          .set(event.staff.toMap());
      await _firebaseFirestore.collection('staff').doc(event.userName).delete();
      emit(CreateStaffLoaded());
    } catch (e) {
      log(e.toString());
      emit(StaffError(error: e.toString()));
    }
  }
}
