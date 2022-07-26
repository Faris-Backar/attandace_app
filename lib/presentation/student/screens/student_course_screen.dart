import 'dart:developer';
import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/pref_resources.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/main.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/student/screens/student_view_course_screen.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentCourseScreen extends StatelessWidget {
  static const routeName = '/StudentCourseScreen';
  const StudentCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(
      GetIndividualStudentEvent(
          userName: prefs.getString(PrefResources.USERNAME)!),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            if (state is StudentLoading) {
              return Util.buildCircularProgressIndicator();
            }
            if (state is GetIndividualStudentsLoaded) {
              Student student = state.student;
              log(student.toString());
              if (student.courses == null) {
                return const Center(
                  child: Text(
                    'No courses Found',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return ListView.separated(
                  itemCount: student.courses!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Card(
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
                            student.courses![index].name[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        title: Text(student.courses![index].name),
                        subtitle: Text(student.courses![index].courseCode),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            StudentViewCourseScreen.routeName,
                            arguments: [
                              student.courses![index],
                              state.attandance,
                              student.assignedClass,
                            ],
                          );
                        },
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
