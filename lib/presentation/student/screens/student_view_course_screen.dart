import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentViewCourseScreen extends StatefulWidget {
  final Course course;
  static const routeName = '/StudentViewCourseScreen';
  const StudentViewCourseScreen({Key? key, required this.course})
      : super(key: key);

  @override
  State<StudentViewCourseScreen> createState() =>
      _StudentViewCourseScreenState();
}

class _StudentViewCourseScreenState extends State<StudentViewCourseScreen> {
  Course? course;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: Column(
          children: [
            BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is GetCourseLoading) {
                  return Util.buildCircularProgressIndicator();
                }
                if (state is GetCourseLoaded) {
                  List<Course> courseList = state.courseList;
                  course = courseList.singleWhere(
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
                                  Text(course!.courseCode),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Hours Taken : '),
                                  Text(course!.totalHoursTaken),
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
            )
          ],
        ),
      ),
    );
  }
}
