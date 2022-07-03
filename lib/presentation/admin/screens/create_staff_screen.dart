import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateStaffScreen extends StatefulWidget {
  static const routeName = '/CreateStaff';
  final String type;
  const CreateStaffScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<CreateStaffScreen> createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  var branches = [
    'CSE',
    'CE',
    'ECE',
    'EEE',
    'ME',
  ];
  String branchValue = 'CSE';
  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Create Staff',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocListener<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is CreateStaffLoaded) {
              nameController.clear();
              usernameController.clear();
              passwordController.clear();
              Navigator.of(context).pop();
            }
          },
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextInputFormFieldWidget(
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
                      inputController: usernameController,
                      textInputType: TextInputType.text,
                      hintText: '',
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
                    DropdownButtonFormField(
                      enableFeedback: true,
                      decoration: InputDecoration(
                        label: const Text('Branch'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: StyleResources.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: StyleResources.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: StyleResources.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelStyle:
                            TextStyle(color: StyleResources.primaryColor),
                      ),
                      value: branchValue,
                      hint: const Text('Select a branch'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: branches.map((String branches) {
                        return DropdownMenuItem(
                          value: branches,
                          child: Text(branches),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          branchValue = newValue! as String;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DefaultButtonWidget(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final staff = Staff(
                          name: nameController.text,
                          username: usernameController.text,
                          password: passwordController.text,
                          branch: branchValue);
                      BlocProvider.of<AdminBloc>(context)
                          .add(CreateStaffEvent(staff: staff));
                    }
                  },
                  title: 'Create',
                  screenSize: screenSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
