import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  List<Staff> staffList = [];
  List<Course> courseList = [];
  AdminBloc() : super(AdminInitial()) {
    on<CreateStaffEvent>(_createStaff);
    on<GetStaffEvent>(_getStaff);
    on<CreateCourseEvent>(_createCourse);
    on<GetCourseEvent>(_getCourse);
  }

  _createStaff(CreateStaffEvent event, Emitter<AdminState> emit) {
    emit(AdminInitial());
    emit(CreateStaffLoading());
    staffList.add(event.staff);
    emit(CreateStaffLoaded());
  }

  _getStaff(GetStaffEvent event, Emitter<AdminState> emit) {
    emit(AdminInitial());
    emit(GetStaffLoading());
    emit(GetStaffLoaded(staffList: staffList));
  }

  _createCourse(CreateCourseEvent event, Emitter<AdminState> emit) {
    emit(AdminInitial());
    emit(AdminLoading());
    courseList.add(event.course);
    emit(AdminLoaded());
  }

  _getCourse(GetCourseEvent event, Emitter<AdminState> emit) {
    emit(AdminInitial());
    emit(GetCourseLoading());
    emit(GetCourseLoaded(courseList: courseList));
  }
}
