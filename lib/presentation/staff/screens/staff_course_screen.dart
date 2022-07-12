import 'dart:developer';

import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/pref_resources.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/main.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:attandance_app/presentation/bloc/staff/staff_bloc.dart';
import 'package:attandance_app/presentation/staff/screens/mark_attandance_screen.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffCourseScreen extends StatelessWidget {
  static const routeName = '/StaffCourseScreen';
  const StaffCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ClassroomBloc>(context).add(GetClassRoomEvent());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: StyleResources.primaryColor,
          title: const Text('Courses'),
        ),
        body: Padding(
          padding: Config.defaultPadding(),
          child: BlocBuilder<ClassroomBloc, ClassroomState>(
            builder: (context, state) {
              if (state is ClassroomLoading) {
                return Util.buildCircularProgressIndicator();
              }
              if (state is ClassRoomLoaded) {
                List<ClassRoom> classRoomList = state.classroomList;
                List<Course> courseList = [];

                classRoomList.map((e) {
                  print('here in map');
                  for (var i = 0; i < e.courses.length; i++) {
                    print('here in loop');
                    bool response =
                        e.courses[i].staff!.name.contains(getUsername());
                    if (response) {
                      print('here ');
                      return courseList.add(e.courses[i]);
                    }
                  }
                }).toList();

                log(classRoomList.toString());
                log(prefs.getString(PrefResources.USERNAME)!);
                log(courseList.toString());
                if (courseList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Courses Found',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: courseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var classroom = classRoomList.singleWhere((element) =>
                        element.courses.contains(courseList[index]));
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(courseList[index].name),
                        subtitle: Text(classroom.name),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        onTap: () {
                          print(classRoomList[index].students);
                          Navigator.of(context).pushNamed(
                            MarkAttandanceScreen.routeName,
                            arguments: [
                              classRoomList[index].students,
                              courseList[index].name
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text(
                  'No Courses Loaded',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ));
  }

  String getUsername() {
    String username = prefs.getString(PrefResources.USERNAME)!;
    return username;
  }
}
