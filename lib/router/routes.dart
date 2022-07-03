import 'package:attandance_app/presentation/admin/screens/admin_home_screen.dart';
import 'package:attandance_app/presentation/admin/screens/class_screen.dart';
import 'package:attandance_app/presentation/admin/screens/course_screen.dart';
import 'package:attandance_app/presentation/admin/screens/create_staff_screen.dart';
import 'package:attandance_app/presentation/admin/screens/staff_screen.dart';
import 'package:attandance_app/presentation/screens/home_screen.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AdminHomeScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const AdminHomeScreen());
      case ClassScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const ClassScreen());
      case CourseScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const CourseScreen());
      case CreateStaffScreen.routeName:
        final arg = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (_) => CreateStaffScreen(
                  type: arg,
                ));
      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case LogInScreen.routeName:
        final args = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (_) => LogInScreen(
                  usertitle: args,
                ));
      case StaffScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const StaffScreen());
      default:
        return CupertinoPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
