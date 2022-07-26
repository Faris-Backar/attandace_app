import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/course_attandance.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  List<Course> courseList = [];
  List<CourseAttandance> courseAttadance = [];
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AdminBloc() : super(AdminInitial()) {
    on<CreateCourseEvent>(_createCourse);
    on<GetCourseEvent>(_getCourse);
    on<GetCourseAttandaceEvent>(_getCourseAttandanceEvent);
  }

  _createCourse(CreateCourseEvent event, Emitter<AdminState> emit) async {
    emit(AdminInitial());
    emit(AdminLoading());
    try {
      final response = await _firebaseFirestore
          .collection('course')
          .doc(event.course.name)
          .set(event.course.toMap());
      emit(AdminLoaded());
    } on FirebaseException catch (e) {
      AdminError(error: e.code);
    }
    emit(AdminLoaded());
  }

  _getCourse(GetCourseEvent event, Emitter<AdminState> emit) async {
    emit(AdminInitial());
    emit(GetCourseLoading());
    try {
      final response = await _firebaseFirestore.collection('course').get();
      final resp = await _firebaseFirestore
          .collection('course')
          .doc(event.courseName)
          .collection(event.className!)
          .get();
      final respon =
          resp.docs.map((e) => CourseAttandance.fromMap(e.data())).toList();
      print(respon.toString());
      final res = response.docs
          .map((docSnap) => Course.fromMap(docSnap.data()))
          .toList();
      courseList = res;
      courseAttadance = respon;
      emit(GetCourseLoaded(
          courseList: courseList, courseAttandace: courseAttadance));
    } on FirebaseException catch (e) {
      emit(AdminError(error: e.code));
    }
  }

  _getCourseAttandanceEvent(
      GetCourseAttandaceEvent event, Emitter<AdminState> emit) async {
    emit(GetCourseLoading());
    try {
      final res = await _firebaseFirestore
          .collection('course')
          .doc(event.courseName)
          .collection('attandance')
          .get();
      final response = res.docs
          .map((docSnap) => CourseAttandance.fromMap(docSnap.data()))
          .toList();
      List<CourseAttandance> courseAttandace = response;
      emit(GetCourseAttandanceLoaded(courseAttandace: courseAttandace));
    } catch (e) {
      rethrow;
    }
  }
}
