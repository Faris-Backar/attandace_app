import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/student/screens/student_course_screen.dart';
import 'package:attandance_app/presentation/student/widgets/student_home_card_widget.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHomeScreen extends StatelessWidget {
  static const routeName = '/StudentHomeScreen';
  const StudentHomeScreen({Key? key}) : super(key: key);

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
                  Navigator.of(context)
                      .pushNamed(StudentCourseScreen.routeName);
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
}
