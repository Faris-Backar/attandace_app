import 'dart:developer';

import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/model/attandance_model.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/course_attandance.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/admin/widgets/drop_down_widget.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentViewCourseScreen extends StatefulWidget {
  final Course course;
  final List<Attandance> attandance;
  final String? type;
  final String className;
  final Student? student;
  static const routeName = '/StudentViewCourseScreen';
  const StudentViewCourseScreen({
    Key? key,
    required this.course,
    required this.attandance,
    required this.className,
    this.type,
    this.student,
  }) : super(key: key);

  @override
  State<StudentViewCourseScreen> createState() =>
      _StudentViewCourseScreenState();
}

class _StudentViewCourseScreenState extends State<StudentViewCourseScreen> {
  late List<String> subjects;
  List<Attandance> attandanceList = [];
  Course? course;
  Course? selectedCourse;
  bool refreshAll = true;
  String subjectValue = '';
  @override
  void initState() {
    super.initState();
    attandanceList = widget.attandance
        .where((element) => element.courseName == widget.course.name)
        .toList();
    course = widget.course;
    BlocProvider.of<AdminBloc>(context).add(
        GetCourseEvent(className: widget.className, courseName: course!.name));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: Column(
          children: [
            if (widget.type != null)
              BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
                if (state is GetIndividualStudentsLoaded) {
                  List<Attandance> attandance = state.attandance;
                  subjects = [];
                  for (var i = 0; i < widget.student!.courses!.length; i++) {
                    subjects.add(widget.student!.courses![i].name);
                  }
                  if (subjectValue == '') {
                    subjectValue = subjects[0];
                  }
                  filterbySubject(
                      subjectName: subjectValue, attandance: attandance);

                  return Column(children: [
                    DropDownFieldWidget(
                        title: 'Subjects',
                        value: subjectValue,
                        item: subjects,
                        onChanged: (value) {
                          setState(() {
                            subjectValue = value!;
                            filterbySubject(
                                subjectName: subjectValue,
                                attandance: attandance);
                          });
                          BlocProvider.of<AdminBloc>(context).add(
                            GetCourseAttandaceEvent(
                                courseName: subjectValue,
                                className: widget.student!.assignedClass!),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ]);
                }

                return Container();
              }),
            BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is GetCourseLoading) {
                  return Util.buildCircularProgressIndicator();
                }
                if (state is GetCourseLoaded) {
                  List<Course> courseList = state.courseList;
                  log('response =>${state.courseAttandace}');
                  List<CourseAttandance> courseAttandance =
                      state.courseAttandace!;
                  selectedCourse = courseList.singleWhere(
                    (element) => element.name.contains(widget.course.name),
                  );
                  return Card(
                    elevation: 5,
                    child: ExpansionTile(
                      title: Text(course!.name),
                      initiallyExpanded: false,
                      childrenPadding: const EdgeInsets.all(8.0),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Course Code : '),
                                  Text(selectedCourse!.courseCode),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Hours Taken : '),
                                  Text(selectedCourse!.totalHoursTaken),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Percentage : '),
                                  Text(
                                    ((attandanceList.length /
                                                double.parse(selectedCourse!
                                                    .totalHoursTaken)) *
                                            100)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: ((attandanceList.length /
                                                      double.parse(selectedCourse!
                                                          .totalHoursTaken)) *
                                                  100) <
                                              75.00
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Present')),
              ],
              rows: attandanceList.map((e) {
                return DataRow(cells: [
                  DataCell(
                    Text(e.date),
                  ),
                  DataCell(Text(e.isPresent == true ? 'Present' : 'Absent')),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: SizedBox(
          height: screenSize.height * .07,
          child: Padding(
            padding: Config.defaultPadding(),
            child:
                BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
              if (state is GetCourseLoading) {
                return Util.buildCircularProgressIndicator();
              }
              if (state is GetCourseLoaded) {
                List<CourseAttandance> courseAttandance =
                    state.courseAttandace!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Attandance Percentage'),
                    Text(
                      ((attandanceList.length /
                                  double.parse(
                                      selectedCourse!.totalHoursTaken)) *
                              100)
                          .toStringAsFixed(2),
                      style: TextStyle(
                        color: ((attandanceList.length /
                                        double.parse(
                                            selectedCourse!.totalHoursTaken)) *
                                    100) <
                                75.00
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }

  filterbySubject(
      {required String subjectName, required List<Attandance> attandance}) {
    attandanceList = attandance
        .where((element) => element.courseName.contains(subjectName))
        .toList();
    print(attandance);
  }
}
