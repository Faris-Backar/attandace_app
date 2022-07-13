import 'package:attandance_app/core/resources/style_resources.dart';
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
    return Scaffold(
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return Util.buildCircularProgressIndicator();
          }
          if (state is GetIndividualStudentsLoaded) {
            Student student = state.student;
            if (student.attandaceList == null) {
              return Util.buildCircularProgressIndicator();
            }
            return ListView.separated(
              itemCount: student.attandaceList!.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
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
                    child: Text(
                      student.attandaceList![index].courseName[0].toString(),
                    ),
                  ),
                  title: Text(student.attandaceList![index].courseName),
                  subtitle: Text(student.attandaceList![index].courseCode),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      StudentViewCourseScreen.routeName,
                      arguments: student.attandaceList![index].courseName,
                    );
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
