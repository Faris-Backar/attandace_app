import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/admin/screens/admin_home_screen.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  final String usertitle;
  const LogInScreen({
    Key? key,
    required this.usertitle,
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
                            Text(
                              widget.usertitle,
                              style: const TextStyle(
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
                            DefaultButtonWidget(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    if (widget.usertitle == 'Admin') {
                                      Navigator.of(context)
                                          .pushNamed(AdminHomeScreen.routeName);
                                    }
                                  } else {}
                                },
                                title: 'Login',
                                screenSize: screenSize),
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
