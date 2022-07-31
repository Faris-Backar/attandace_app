import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/pref_resources.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/main.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/bloc/attandance/attandance_bloc.dart';
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
  bool isUnder = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentBloc>(context).add(
      GetIndividualStudentEvent(
          userName: prefs.getString(PrefResources.USERNAME)!),
    );
    BlocProvider.of<AdminBloc>(context).add(GetCourseEvent(
        className: prefs.getString(PrefResources.CLASSROOM_NAME)));

    // checktotalAttandance();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isUnder ? Colors.red : StyleResources.primaryColor,
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
        child: BlocListener<AttandanceBloc, AttandanceState>(
          listener: (context, state) {
            if (state is StudentIsunderState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Attandance Under  ",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  content: const Text(
                      "you are attandance is Under for further details check your attandance or contact staff coordinator"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            isUnder = true;
                          });
                        },
                        child: const Text('OK'))
                  ],
                ),
              );
            }
          },
          child: BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              print('heree in bloc');
              print(state);
              if (state is GetCourseLoading) {
                return Util.buildCircularProgressIndicator();
              }
              if (state is GetCourseLoaded) {
                List<Course> courseList = state.courseList;
                return BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, state) {
                    print(state);
                    if (state is GetIndividualStudentsLoaded) {
                      Student student = state.student;
                      var attandanceList = state.attandance;
                      var attandance = [];
                      for (var i = 0; i < courseList.length; i++) {
                        final response = (attandanceList.length /
                                    double.parse(
                                        courseList[i].totalHoursTaken)) *
                                100 <
                            70;
                        print('response is =>$response');
                        if (response) {
                          attandance.add('under');
                        } else {
                          attandance.add('not under');
                        }
                      }
                      int underSubjects = attandance
                          .where((element) => element == 'under')
                          .length;
                      if (attandance.contains('under')) {
                        BlocProvider.of<AttandanceBloc>(context)
                            .add(StundetIsUnderEvent());
                      }
                      return Column(
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
                                  return Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          LogInScreen.routeName,
                                          (route) => false);
                                });
                              }
                              return StudentHomeCardWidget(
                                screenSize: screenSize,
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(SignOutEvent());
                                },
                                title: 'Log Out',
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                );
              }
              return Column(
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
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignOutEvent());
                        },
                        title: 'Log Out',
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: isUnder
          ? Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.red,
              child: const Text(
                'Important ! Attandance is Under..',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}
