import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/admin/widgets/drop_down_widget.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateStudentScreen extends StatefulWidget {
  static const routeName = '/CreateStudentScreen';
  final Student? student;
  final int? index;
  const CreateStudentScreen({Key? key, this.student, this.index})
      : super(key: key);

  @override
  State<CreateStudentScreen> createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final registrationController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  var branches = [
    'CSE',
    'CE',
    'ECE',
    'EEE',
    'ME',
  ];
  var year = [
    '1',
    '2',
    '3',
    '4',
  ];
  var semester = [
    'S1',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'S7',
    'S8',
  ];
  String branchValue = 'CSE';
  String yearValue = '1';
  String semValue = 'S1';
  bool isEnabled = true;
  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      isEnabled = false;
      nameController.text = widget.student!.name;
      registrationController.text = widget.student!.registrationNumber;
      usernameController.text = widget.student!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: Text(
          widget.student != null ? 'Update Student' : 'Create Student',
          style: const TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
        actions: [
          if (widget.student != null)
            isEnabled
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isEnabled = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isEnabled = true;
                      });
                    },
                    icon: const Icon(Icons.edit_rounded),
                  ),
        ],
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocListener<StudentBloc, StudentState>(
          listener: (context, state) {
            if (state is CreateStudentLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  content: Text(
                      'You are SuccessFully Added Student : ${nameController.text}'),
                ),
              );
              nameController.clear();
              registrationController.clear();
              usernameController.clear();
              passwordController.clear();
              Navigator.of(context).pop();
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextInputFormFieldWidget(
                    isEnabled: isEnabled,
                    inputController: nameController,
                    textInputType: TextInputType.text,
                    hintText: '',
                    validatorFunction: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                    label: 'Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputFormFieldWidget(
                    isEnabled: isEnabled,
                    inputController: registrationController,
                    textInputType: TextInputType.text,
                    hintText: '',
                    validatorFunction: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Registration';
                      }
                      return null;
                    },
                    label: 'Registration',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputFormFieldWidget(
                    isEnabled: isEnabled,
                    inputController: usernameController,
                    textInputType: TextInputType.text,
                    hintText: '',
                    validatorFunction: (value) {
                      String pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern);
                      if (value == null ||
                          value.isEmpty ||
                          !regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.student == null)
                    TextInputFormFieldWidget(
                      isEnabled: isEnabled,
                      inputController: passwordController,
                      textInputType: TextInputType.text,
                      hintText: '',
                      validatorFunction: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid password';
                        } else if (value.length < 6) {
                          return 'Please Enter a password with minimum 6 chars';
                        } else {
                          return null;
                        }
                      },
                      label: 'Password',
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropDownFieldWidget(
                      title: 'Branch',
                      value: branchValue,
                      item: branches,
                      onChanged: (newValue) {
                        setState(() {
                          branchValue = newValue!;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  DropDownFieldWidget(
                    title: 'Year',
                    value: yearValue,
                    item: year,
                    onChanged: (newValue) {
                      setState(() {
                        yearValue = newValue!;
                        if (yearValue == '1') {
                          semValue = 'S1';
                        } else if (yearValue == '2') {
                          semValue = 'S3';
                        } else if (yearValue == '3') {
                          semValue = 'S5';
                        } else if (yearValue == '4') {
                          semValue = 'S7';
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropDownFieldWidget(
                      title: 'Semester',
                      value: semValue,
                      item: semester,
                      onChanged: (newValue) {
                        setState(() {
                          semValue = newValue!;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isEnabled)
                    BlocBuilder<StudentBloc, StudentState>(
                      builder: (context, state) {
                        if (state is StudentLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: StyleResources.primaryColor,
                            ),
                          );
                        }
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: DefaultButtonWidget(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                final student = Student(
                                  name: nameController.text,
                                  registrationNumber:
                                      registrationController.text,
                                  email: usernameController.text,
                                  password: passwordController.text,
                                  department: branchValue,
                                  year: yearValue,
                                  semester: semValue,
                                );
                                if (widget.student != null) {
                                  BlocProvider.of<StudentBloc>(context).add(
                                    UpdateStudentEvent(
                                        student: student,
                                        index: widget.index!,
                                        name: widget.student!.name),
                                  );
                                } else {
                                  BlocProvider.of<StudentBloc>(context).add(
                                      CreateStudentEvent(
                                          student: student,
                                          password: passwordController.text));
                                }
                              }
                            },
                            title: widget.student != null ? 'Update' : 'Create',
                            screenSize: screenSize,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
