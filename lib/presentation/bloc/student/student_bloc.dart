import 'dart:developer';
import 'package:attandance_app/model/student.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final _firebaseFirestore = FirebaseFirestore.instance;
  List<Student> studentList = [];
  List<Student> filteredStudentsList = [];
  StudentBloc() : super(StudentInitial()) {
    on<CreateStudentEvent>(_createStudent);
    on<GetStudentEvent>(_getStudent);
    on<UpdateStudentEvent>(_updateStudent);
    on<GetFilteredStudentsAccordingtoSemester>(
        _getFilteredStudentsAccordingtoSemester);
    on<DeleteFilteredStudentsAccordingtoSemester>(
        _deleteFilteredStudentsAccordingtoSemester);
    on<GetIndividualStudentEvent>(_getIndividualStudent);
  }

  _createStudent(CreateStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentInitial());
    emit(StudentLoading());
    final _auth = FirebaseAuth.instance;
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: event.student.email, password: event.password);
      final addUserInfo =
          await _firebaseFirestore.collection('user').doc(res.user!.uid).set({
        'name': event.student.name,
        'role': 'student',
      });
      try {
        final response = await _firebaseFirestore
            .collection('student')
            .doc(event.student.name)
            .set(event.student.toMap());
      } on FirebaseException catch (e) {
        StudentError(error: e.code);
      }
      emit(CreateStudentLoaded());
    } on FirebaseAuthException catch (e) {
      emit(StudentError(error: e.code));
    }
    emit(CreateStudentLoaded());
  }

  _getStudent(GetStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentInitial());
    emit(StudentLoading());
    try {
      final response = await _firebaseFirestore.collection('student').get();
      final res = response.docs
          .map((docSnap) => Student.fromMap(docSnap.data()))
          .toList();
      studentList = res;
      log(studentList.toString());
      emit(GetStudentLoaded(studentList: studentList));
    } on FirebaseException catch (e) {
      emit(StudentError(error: e.code));
    }
    emit(GetStudentLoaded(studentList: studentList));
  }

  _updateStudent(UpdateStudentEvent event, Emitter<StudentState> emit) {
    emit(StudentInitial());
    emit(StudentLoading());
    studentList.removeAt(event.index);
    studentList.insert(
      event.index,
      event.student,
    );
    emit(CreateStudentLoaded());
  }

  _getFilteredStudentsAccordingtoSemester(
      GetFilteredStudentsAccordingtoSemester event,
      Emitter<StudentState> emit) {
    emit(StudentInitial());
    emit(StudentLoading());
    filteredStudentsList = studentList
        .where((student) => student.semester.contains(event.semester))
        .toList();
    emit(GetStudentLoaded(studentList: filteredStudentsList));
  }

  _deleteFilteredStudentsAccordingtoSemester(
      DeleteFilteredStudentsAccordingtoSemester event,
      Emitter<StudentState> emit) {
    emit(StudentInitial());
    emit(StudentLoading());
    filteredStudentsList.remove(event.student);
    emit(GetStudentLoaded(studentList: filteredStudentsList));
  }

  _getIndividualStudent(
      GetIndividualStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentInitial());
    emit(StudentLoading());
    try {
      final response = await _firebaseFirestore
          .collection('students')
          .doc(event.userName)
          .get();
      final res = Student.fromMap(response.data()!);
      Student student = res;
      emit(GetIndividualStudentsLoaded(student: student));
    } on FirebaseException catch (e) {
      emit(StudentError(error: e.code));
    }
  }
}
