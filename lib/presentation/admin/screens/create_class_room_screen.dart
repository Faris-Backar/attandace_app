import 'dart:developer';

import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/admin/screens/add_student_screen.dart';
import 'package:attandance_app/presentation/admin/widgets/drop_down_widget.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:attandance_app/presentation/bloc/staff/staff_bloc.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateClassRoomScreen extends StatefulWidget {
  static const routeName = '/CreateClassRoomScreen';
  const CreateClassRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateClassRoomScreen> createState() => _CreateClassRoomState();
}

class _CreateClassRoomState extends State<CreateClassRoomScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  List<String> subject = [];
  List<String> staff = [];
  List<String> staffAdvisor = [];
  List<String> courseList = [];
  List<Course> selectedcourseList = [];
  List<Student> selectedStudentsList = [];
  String? courseValue;
  String subjectValue = '';
  String staffValue = '';
  String? staffAdvisorValue;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StaffBloc>(context).add(GetStaffEvent());
    BlocProvider.of<ClassroomBloc>(context).add(GetClassRoomStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Create Class Room',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded))
        ],
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: SingleChildScrollView(
          child: Form(
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
                const SizedBox(height: 20),
                BlocBuilder<StaffBloc, StaffState>(
                  builder: (context, state) {
                    if (state is StaffLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: StyleResources.primaryColor,
                        ),
                      );
                    }
                    if (state is GetStaffLoaded) {
                      staffAdvisor.clear();
                      for (var i = 0; i < state.staffList.length; i++) {
                        staffAdvisor.add(state.staffList[i].name);
                      }
                      staffAdvisorValue = staffAdvisor[0];
                      log(staffAdvisor.toString());
                      return DropDownFieldWidget(
                          title: 'Staff Advisor',
                          value: staffAdvisorValue!,
                          item: staffAdvisor,
                          onChanged: (value) {
                            setState(() {
                              staffAdvisorValue = value!;
                            });
                          });
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subjects',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<AdminBloc>(context)
                              .add(GetCourseEvent());
                          List<Course> subjectList = [];
                          List<Staff> staffSelectedList = [];
                          Course course;
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            context: context,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey),
                                  ),
                                  BlocBuilder<AdminBloc, AdminState>(
                                    builder: (context, state) {
                                      if (state is GetCourseLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                              color:
                                                  StyleResources.primaryColor),
                                        );
                                      }
                                      if (state is GetCourseLoaded) {
                                        subjectList = state.courseList;
                                        courseList.clear();
                                        for (var i = 0;
                                            i < state.courseList.length;
                                            i++) {
                                          courseList
                                              .add(state.courseList[i].name);
                                        }
                                        log(courseList.toString());
                                        courseValue = courseList[0];
                                        return DropDownFieldWidget(
                                            title: 'Course',
                                            value: courseValue!,
                                            item: courseList,
                                            onChanged: (value) {
                                              setState(() {
                                                courseValue = value!;
                                              });
                                            });
                                      }
                                      return Container();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  BlocBuilder<StaffBloc, StaffState>(
                                    builder: (context, state) {
                                      if (state is StaffLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: StyleResources.primaryColor,
                                          ),
                                        );
                                      }
                                      if (state is GetStaffLoaded) {
                                        staffSelectedList = state.staffList;
                                        staff.clear();
                                        for (var i = 0;
                                            i < state.staffList.length;
                                            i++) {
                                          staff.add(state.staffList[i].name);
                                        }
                                        staffValue = staff[0];
                                        log(staff.toString());
                                        return DropDownFieldWidget(
                                            title: 'Staff Advisor',
                                            value: staffValue,
                                            item: staff,
                                            onChanged: (value) {
                                              setState(() {
                                                staffValue = value!;
                                              });
                                            });
                                      }
                                      return Container();
                                    },
                                  ),
                                  DefaultButtonWidget(
                                      onTap: () {
                                        course = subjectList.singleWhere(
                                            (course) =>
                                                course.name == courseValue);
                                        final staffSelected = staffSelectedList
                                            .singleWhere((element) =>
                                                element.name == staffValue);
                                        final createdCourse = Course(
                                            name: course.name,
                                            courseCode: course.courseCode,
                                            staff: staffSelected);
                                        log('Created Course=> $createdCourse');
                                        setState(() {
                                          selectedcourseList.add(createdCourse);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      title: 'Create Subject',
                                      screenSize: screenSize)
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_outlined)),
                  ],
                ),
                if (selectedcourseList.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedcourseList.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 5.0,
                      child: ListTile(
                        leading: Text(selectedcourseList[index].courseCode),
                        title: Text(selectedcourseList[index].name),
                        subtitle: Text(selectedcourseList[index].staff!.name),
                      ),
                    ),
                  ),
                BlocListener<ClassroomBloc, ClassroomState>(
                  listener: (context, state) {
                    if (state is GetClassRoomStudents) {
                      selectedStudentsList = state.studentList;
                    }
                  },
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Students',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddStudentScreen.routeName);
                      },
                      icon: const Icon(Icons.add_outlined),
                    ),
                  ],
                ),
                if (selectedStudentsList.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedStudentsList.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 5.0,
                      child: ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: StyleResources.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            selectedStudentsList[index].name[0].toUpperCase(),
                            style: const TextStyle(
                                color: StyleResources.accentColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        title: Text(selectedStudentsList[index].name),
                        subtitle: Text(
                            selectedStudentsList[index].registrationNumber),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ClassroomBloc, ClassroomState>(
                  builder: (context, state) {
                    if (state is ClassroomLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: StyleResources.primaryColor),
                      );
                    }
                    if (state is ClassRoomLoaded) {
                      Navigator.of(context).pop();
                    }
                    return DefaultButtonWidget(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final classroom = ClassRoom(
                                name: nameController.text,
                                staffAdvicer: staffAdvisorValue!,
                                students: selectedStudentsList,
                                courses: selectedcourseList);
                            BlocProvider.of<ClassroomBloc>(context).add(
                                CreateClassRoomEvent(classRoom: classroom));
                          }
                        },
                        title: 'Create ClassRoom',
                        screenSize: screenSize);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
