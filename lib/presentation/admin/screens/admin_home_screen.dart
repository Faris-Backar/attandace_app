import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/admin/screens/class_screen.dart';
import 'package:attandance_app/presentation/admin/screens/course_screen.dart';
import 'package:attandance_app/presentation/admin/screens/staff_screen.dart';
import 'package:attandance_app/presentation/admin/screens/student_screen.dart';
import 'package:attandance_app/presentation/admin/widgets/admin_card_widget.dart';
import 'package:attandance_app/presentation/admin/widgets/admin_drawer_widget.dart';
import 'package:attandance_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = 'AdminHomeScreen';
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Home',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // if (state is AuthSignOutStateLoaded) {
              //   // Navigator.of(context).pushNamedAndRemoveUntil(
              //   //     LogInScreen.routeName, (route) => false);
              //   Future.delayed(Duration.zero, () {
              //     return Navigator.of(context).pushNamedAndRemoveUntil(
              //         LogInScreen.routeName, (route) => false);
              //   });
              // }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Util.buildCircularProgressIndicator();
              }
              if (state is AuthSignOutStateLoaded) {
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     LogInScreen.routeName, (route) => false);
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
      // drawer: AdminDrawerWidget(screenSize: screenSize),
      body: Padding(
        padding: Config.defaultPadding(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AdminCardWidget(
                  screenSize: screenSize,
                  label: 'Course',
                  ontap: () {
                    Navigator.of(context).pushNamed(CourseScreen.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
              AdminCardWidget(
                  screenSize: screenSize,
                  label: 'Staff',
                  ontap: () {
                    Navigator.of(context).pushNamed(StaffScreen.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
              AdminCardWidget(
                  screenSize: screenSize,
                  label: 'Student',
                  ontap: () {
                    Navigator.of(context).pushNamed(StudentScreen.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
              AdminCardWidget(
                  screenSize: screenSize,
                  label: 'Class',
                  ontap: () {
                    Navigator.of(context).pushNamed(ClassScreen.routeName);
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
