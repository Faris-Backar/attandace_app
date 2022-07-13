import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/student.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  final _firebaseFirestore = FirebaseFirestore.instance;
  List<ClassRoom> classroomList = [];
  List<Student> studentsList = [];
  ClassroomBloc() : super(ClassroomInitial()) {
    on<CreateClassRoomEvent>(_createClassRoom);
    on<GetClassRoomEvent>(_getClassRoom);
    on<AddClassRoomStudentsEvent>(_addSelectedStudents);
    on<GetClassRoomStudentsEvent>(_getClassRoomStudents);
    on<DeleteClassRoomStudentsEvent>(_deleteClassRoomStudents);
  }
  _createClassRoom(
      CreateClassRoomEvent event, Emitter<ClassroomState> emit) async {
    emit(ClassroomInitial());
    emit(ClassroomLoading());

    try {
      final response = await _firebaseFirestore
          .collection('classroom')
          .doc(event.classRoom.name)
          .set(event.classRoom.toMap());
      for (var i = 0; i < event.classRoom.courses.length; i++) {
        // await _firebaseFirestore.collection('AssignedCourses').doc(event.classRoom.courses[i].name).set(event.classRoom.);
      }
    } on FirebaseException catch (e) {
      ClassRoomError(error: e.code);
    }
    emit(CreateClassroomLoaded());
  }

  _getClassRoom(GetClassRoomEvent event, Emitter<ClassroomState> emit) async {
    emit(ClassroomInitial());
    emit(ClassroomLoading());
    try {
      final response = await _firebaseFirestore.collection('classroom').get();
      final res = response.docs
          .map((docSnap) => ClassRoom.fromMap(docSnap.data()))
          .toList();
      classroomList = res;

      emit(ClassRoomLoaded(classroomList: classroomList));
    } on FirebaseException catch (e) {
      emit(ClassRoomError(error: e.code));
    }
  }

  _addSelectedStudents(
      AddClassRoomStudentsEvent event, Emitter<ClassroomState> emit) {
    emit(ClassroomInitial());
    emit(ClassroomLoading());
    studentsList = event.studentsList;
    emit(GetClassRoomStudents(studentList: studentsList));
  }

  _getClassRoomStudents(
      GetClassRoomStudentsEvent event, Emitter<ClassroomState> emit) {
    emit(ClassroomInitial());
    emit(ClassroomLoading());
    emit(GetClassRoomStudents(studentList: studentsList));
  }

  _deleteClassRoomStudents(
      DeleteClassRoomStudentsEvent event, Emitter<ClassroomState> emit) {
    emit(ClassroomInitial());
    emit(ClassroomLoading());
    emit(GetClassRoomStudents(studentList: studentsList));
  }
}
