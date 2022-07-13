import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/bloc/attandance/attandance_bloc.dart';
import 'package:attandance_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:attandance_app/presentation/bloc/staff/staff_bloc.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/screens/splash_screen.dart';
import 'package:attandance_app/presentation/student/screens/student_home_screen.dart';
import 'package:attandance_app/router/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const AttandanceApp());
}

class AttandanceApp extends StatelessWidget {
  const AttandanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<AdminBloc>(
          create: (context) => AdminBloc(),
        ),
        BlocProvider<StaffBloc>(
          create: (context) => StaffBloc(),
        ),
        BlocProvider<StudentBloc>(
          create: (context) => StudentBloc(),
        ),
        BlocProvider<ClassroomBloc>(
          create: (context) => ClassroomBloc(),
        ),
        BlocProvider<AttandanceBloc>(
          create: (context) => AttandanceBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
