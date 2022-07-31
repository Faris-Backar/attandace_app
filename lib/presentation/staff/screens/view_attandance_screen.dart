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
import 'package:intl/intl.dart';

class ViewAttandanceScreen extends StatefulWidget {
  final Student student;
  static const routeName = '/ViewAttandanceScreen';
  const ViewAttandanceScreen({Key? key, required this.student})
      : super(key: key);

  @override
  State<ViewAttandanceScreen> createState() => _ViewAttandanceScreenState();
}

class _ViewAttandanceScreenState extends State<ViewAttandanceScreen> {
  bool refreshAll = true;
  String subjectValue = '';
  late List<String> subjects;
  List<Attandance> attandanceList = [];
  Course? course;
  Course? selectedCourse;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentBloc>(context).add(
      GetIndividualStudentEvent(userName: widget.student.name),
    );
    BlocProvider.of<AdminBloc>(context).add(const GetCourseEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.student.name,
        ),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            if (state is GetIndividualStudentsLoaded) {
              List<Attandance> attandance = state.attandance;
              subjects = [];
              log('res=>' + widget.student.courses.toString());
              for (var i = 0; i < widget.student.courses!.length; i++) {
                subjects.add(widget.student.courses![i].name);
              }
              if (subjectValue == '') {
                subjectValue = subjects[0];
              }
              filterbySubject(
                  subjectName: subjectValue, attandance: attandance);

              return Column(
                children: [
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
                        // BlocProvider.of<AdminBloc>(context).add(
                        //   GetCourseAttandaceEvent(
                        //       courseName: subjectValue,
                        //       className: widget.student.assignedClass!),
                        // );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  if (attandanceList.isEmpty)
                    const Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
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
                          (element) => element.name.contains(subjectValue),
                        );
                        return DataTable(
                          columns: const [
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Present')),
                          ],
                          rows: attandanceList.map((e) {
                            return DataRow(cells: [
                              DataCell(
                                Text(DateFormat('dd-MM-yyyy hh:mm a')
                                    .format(DateTime.parse(e.date))),
                              ),
                              DataCell(Text(
                                  e.isPresent == true ? 'Present' : 'Absent')),
                            ]);
                          }).toList(),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              );
            }
            return Container();
          },
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
