import 'dart:developer';
import 'package:attandance_app/model/attandance_model.dart';
import 'package:attandance_app/model/student.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    on<DeleteStudentEvent>(_deleteStudents);
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
      // print(res.user!.uid);
      try {
        final response = await _firebaseFirestore
            .collection('student')
            .doc(event.student.name)
            .set(event.student.toMap())
            .then((value) async => await _firebaseFirestore
                .collection('student')
                .doc(event.student.name)
                .update({'uid': res.user!.uid}));
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

  _updateStudent(UpdateStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentInitial());
    emit(StudentLoading());
    try {
      await _firebaseFirestore
          .collection('student')
          .doc(event.student.name)
          .set(event.student.toMap());
      emit(CreateStudentLoaded());
    } catch (e) {
      log(e.toString());
      emit(StudentError(error: e.toString()));
    }
  }

  _getFilteredStudentsAccordingtoSemester(
      GetFilteredStudentsAccordingtoSemester event,
      Emitter<StudentState> emit) {
    emit(StudentInitial());
    emit(StudentLoading());
    filteredStudentsList = studentList
        .where(
          (student) =>
              student.semester == event.semester &&
              student.department == event.branch,
        )
        .toList();
    print('filter => $filteredStudentsList');
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
    List<Attandance> attandace = [];
    print(event.userName);
    try {
      final response = await _firebaseFirestore
          .collection('student')
          .doc(event.userName)
          .get();
      final attandanceResponse = await _firebaseFirestore
          .collection('student')
          .doc(event.userName)
          .collection('attandance')
          .get();
      Student student = Student.fromMap(response.data()!);
      List<Attandance> attandanceList = attandanceResponse.docs
          .map((docSnap) => Attandance.fromMap(docSnap.data()))
          .toList();
      emit(GetIndividualStudentsLoaded(
          student: student, attandance: attandanceList));
    } on FirebaseException catch (e) {
      emit(StudentError(error: e.code));
    }
  }

  _deleteStudents(DeleteStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentInitial());
    emit(StudentLoading());
    try {
      await _firebaseFirestore
          .collection('student')
          .doc(event.username)
          .delete();
      await _firebaseFirestore
          .collection('student')
          .doc(event.username)
          .collection('attandance')
          .doc()
          .delete();
      await _firebaseFirestore.collection('user').doc(event.uid).delete();
      emit(GetStudentLoaded(studentList: filteredStudentsList));
    } catch (e) {
      emit(StudentError(error: e.toString()));
    }
  }
}
