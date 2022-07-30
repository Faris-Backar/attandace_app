import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/pref_resources.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/main.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/course_attandance.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/student/screens/student_course_screen.dart';
import 'package:attandance_app/presentation/student/widgets/student_home_card_widget.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHomeScreen extends StatefulWidget {
  static const routeName = '/StudentHomeScreen';
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentBloc>(context).add(
      GetIndividualStudentEvent(
          userName: prefs.getString(PrefResources.USERNAME)!),
    );
    // BlocProvider.of<AdminBloc>(context).add(
    //     GetCourseEvent(className: widget.className, courseName: course!.name));
    checktotalAttandance();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text('Home'),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AuthLoading) {
                return Util.buildCircularProgressIndicator();
              }
              if (state is AuthSignOutStateLoaded) {
                Future.delayed(Duration.zero, () {
                  return Navigator.of(context).pushNamedAndRemoveUntil(
                      LogInScreen.routeName, (route) => false);
                });
              }

              return IconButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                },
                icon: const Icon(
                  Icons.logout_outlined,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: Column(
          children: [
            StudentHomeCardWidget(
                screenSize: screenSize,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    StudentCourseScreen.routeName,
                  );
                },
                title: 'View Attandance'),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Util.buildCircularProgressIndicator();
                }
                if (state is AuthSignOutStateLoaded) {
                  Future.delayed(Duration.zero, () {
                    return Navigator.of(context).pushNamedAndRemoveUntil(
                        LogInScreen.routeName, (route) => false);
                  });
                }
                return StudentHomeCardWidget(
                  screenSize: screenSize,
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                  },
                  title: 'Log Out',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  checktotalAttandance() {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is GetCourseLoading) {
          return Util.buildCircularProgressIndicator();
        }
        if (state is GetCourseLoaded) {
          List<Course> courseList = state.courseList;
          List<CourseAttandance> courseAttandance = state.courseAttandace!;
          return BlocBuilder<StudentBloc, StudentState>(
            builder: (context, state) {
              if (state is GetIndividualStudentsLoaded) {
                Student student = state.student;
                var attandanceList = state.attandance;
                var attandance = [];
                for (var i = 0; i < courseList.length; i++) {
                  final response =
                      (attandanceList.length / courseAttandance.length) * 100 <
                          70;
                  if (response) {
                    attandance.add('under');
                  } else {
                    attandance.add('not under');
                  }
                }
                int underSubjects =
                    attandance.where((element) => element == 'under').length;
                if (attandance.contains('under')) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Attandance Under  ",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      content: Text(
                          "you are attandance in $underSubjects subjects for further details check your attandance or contact staff coordinator"),
                    ),
                  );
                }
              }
              return Container();
            },
          );
        }
        return Container();
      },
    );
  }
}
