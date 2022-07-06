import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/admin/screens/add_student_screen.dart';
import 'package:attandance_app/presentation/admin/screens/admin_home_screen.dart';
import 'package:attandance_app/presentation/admin/screens/class_screen.dart';
import 'package:attandance_app/presentation/admin/screens/course_screen.dart';
import 'package:attandance_app/presentation/admin/screens/create_class_room_screen.dart';
import 'package:attandance_app/presentation/admin/screens/create_staff_screen.dart';
import 'package:attandance_app/presentation/admin/screens/create_student_screen.dart';
import 'package:attandance_app/presentation/admin/screens/staff_screen.dart';
import 'package:attandance_app/presentation/admin/screens/student_screen.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AddStudentScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const AddStudentScreen());
      case AdminHomeScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const AdminHomeScreen());
      case ClassScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const ClassScreen());
      case CourseScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const CourseScreen());
      case CreateClassRoomScreen.routeName:
        final arg = settings.arguments;
        if (arg == null) {
          return CupertinoPageRoute(
              builder: (_) => const CreateClassRoomScreen());
        } else {
          final args = arg as List;
          return CupertinoPageRoute(
              builder: (_) => CreateStaffScreen(
                    staff: args[0] as Staff,
                    index: args[1] as int,
                  ));
        }
      case CreateStaffScreen.routeName:
        final arg = settings.arguments;
        if (arg == null) {
          return CupertinoPageRoute(builder: (_) => const CreateStaffScreen());
        } else {
          final args = arg as List;
          return CupertinoPageRoute(
              builder: (_) => CreateStaffScreen(
                    staff: args[0] as Staff,
                    index: args[1] as int,
                  ));
        }

      case CreateStudentScreen.routeName:
        final arg = settings.arguments;
        if (arg == null) {
          return CupertinoPageRoute(
              builder: (_) => const CreateStudentScreen());
        } else {
          final args = arg as List;
          return CupertinoPageRoute(
              builder: (_) => CreateStudentScreen(
                    student: args[0] as Student,
                    index: args[1] as int,
                  ));
        }
      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case LogInScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const LogInScreen());
      case StaffScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const StaffScreen());
      case StudentScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const StudentScreen());
      default:
        return CupertinoPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
