import 'package:attandance_app/model/course.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  List<Course> courseList = [];
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AdminBloc() : super(AdminInitial()) {
    on<CreateCourseEvent>(_createCourse);
    on<GetCourseEvent>(_getCourse);
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
      final res = response.docs
          .map((docSnap) => Course.fromMap(docSnap.data()))
          .toList();
      courseList = res;
      emit(GetCourseLoaded(courseList: courseList));
    } on FirebaseException catch (e) {
      emit(AdminError(error: e.code));
    }
    emit(GetCourseLoaded(courseList: courseList));
  }
}
