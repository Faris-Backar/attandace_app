import 'dart:async';

import 'package:attandance_app/core/resources/pref_resources.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/main.dart';
import 'package:attandance_app/presentation/admin/screens/admin_home_screen.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/staff/screens/staff_home_screen.dart';
import 'package:attandance_app/presentation/student/screens/student_home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleResources.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'ATTANDANCE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'MANAGER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  checkUserLoggedIn() async {
    final userLoggedIn = prefs.getBool(PrefResources.IS_LOGGEDIN);
    final user = prefs.getString(PrefResources.LOGGED_USER_ROLE);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (userLoggedIn == null || userLoggedIn == false) {
      gotoLogin();
    } else {
      if (user == 'admin') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AdminHomeScreen.routeName, (route) => false);
      } else if (user == 'student') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            StudentHomeScreen.routeName, (route) => false);
      } else if (user == 'staff') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            StaffHomeScreen.routeName, (route) => false);
      }
    }
  }

  gotoLogin() async {
    Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
  }
}
