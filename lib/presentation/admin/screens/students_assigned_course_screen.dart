import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsAssignedCourseScreen extends StatelessWidget {
  static const routeName = '/StudentsAssignedCourseScreen';
  final String studnetName;
  const StudentsAssignedCourseScreen({Key? key, required this.studnetName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context)
        .add(GetIndividualStudentEvent(userName: studnetName));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return Util.buildCircularProgressIndicator();
          }
          if (state is GetIndividualStudentsLoaded) {
            Student student = state.student;
            return Padding(
              padding: Config.defaultPadding(),
              child: ListView.builder(
                  itemCount: student.courses!.length,
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
                              student.courses![index].name[0].toUpperCase(),
                              style: const TextStyle(
                                  color: StyleResources.accentColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          title: Text(student.courses![index].name),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            //   Navigator.of(context).pushNamed(
                            //       StudentsAssignedCourseScreen.routeName,
                            //       arguments: widget.classRoom.students[index].name);
                          },
                        ),
                      )),
            );
          }
          return Container();
        },
      ),
    );
  }
}
