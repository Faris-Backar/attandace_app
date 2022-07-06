import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/admin/widgets/admin_drawer_widget.dart';
import 'package:attandance_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
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
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(
                  child: CircularProgressIndicator(
                      color: StyleResources.primaryColor),
                );
              }
              if (state is AuthSigOutState) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LogInScreen.routeName, (route) => false);
              }
              return IconButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                },
                icon: Icon(
                  Icons.logout_outlined,
                ),
              );
            },
          ),
        ],
      ),
      drawer: AdminDrawerWidget(screenSize: screenSize),
    );
  }
}
