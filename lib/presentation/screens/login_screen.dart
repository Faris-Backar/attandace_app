import 'dart:developer';

import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/admin/screens/admin_home_screen.dart';
import 'package:attandance_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LogInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      backgroundColor: StyleResources.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: Config.defaultPadding(),
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: StyleResources.accentColor,
                elevation: 5,
                child: SizedBox(
                  width: screenSize.width,
                  child: Padding(
                    padding: Config.defaultPadding(),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextInputFormFieldWidget(
                              inputController: usernameController,
                              textInputType: TextInputType.text,
                              hintText: 'Eg:- admin@admin.com',
                              validatorFunction: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                              label: 'Username',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextInputFormFieldWidget(
                              inputController: passwordController,
                              textInputType: TextInputType.text,
                              hintText: '',
                              validatorFunction: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              label: 'Password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthLoaded) {
                                  String role = state.role;
                                  if (role == 'admin') {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            AdminHomeScreen.routeName,
                                            (route) => false);
                                  }
                                }
                                if (state is AuthError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.error),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor:
                                          StyleResources.errorColor,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: StyleResources.primaryColor),
                                  );
                                }

                                return DefaultButtonWidget(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                            SignInEvent(
                                                email: usernameController.text,
                                                password:
                                                    passwordController.text));
                                      }
                                    },
                                    title: 'Login',
                                    screenSize: screenSize);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
