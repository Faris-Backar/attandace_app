import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:attandance_app/presentation/bloc/staff/staff_bloc.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/staff/screens/staff_course_screen.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:attandance_app/presentation/widgets/home_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffHomeScreen extends StatelessWidget {
  static const routeName = '/StaffHomeScreen';
  const StaffHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: StyleResources.primaryColor,
          title: const Text('Home'),
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
        body: Padding(
          padding: Config.defaultPadding(),
          child: Column(
            children: [
              HomeCardWidget(
                screenSize: screenSize,
                onTap: () {
                  Navigator.of(context).pushNamed(StaffCourseScreen.routeName);
                },
                title: 'Courses',
              ),
              const SizedBox(
                height: 20,
              ),
              // HomeCardWidget(
              //   screenSize: screenSize,
              //   onTap: () {},
              //   title: '',
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // HomeCardWidget(
              //   screenSize: screenSize,
              //   onTap: () {},
              //   title: 'Courses',
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ));
  }
}
