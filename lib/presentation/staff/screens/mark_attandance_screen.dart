import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/attandance_model.dart';
import 'package:attandance_app/model/class_attandance_model.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/bloc/attandance/attandance_bloc.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarkAttandanceScreen extends StatefulWidget {
  static const routeName = '/MarkAttandanceScreen';
  final ClassRoom classRoom;
  final Course course;
  const MarkAttandanceScreen({
    Key? key,
    required this.classRoom,
    required this.course,
  }) : super(key: key);

  @override
  State<MarkAttandanceScreen> createState() => _MarkAttandanceScreenState();
}

class _MarkAttandanceScreenState extends State<MarkAttandanceScreen> {
  Course? course;
  List<Student> markedStudentsList = [];
  late List<Student> studentList;

  bool checkedValue = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminBloc>(context).add(GetCourseEvent());
    studentList = widget.classRoom.students;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text('Attandance'),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      if (markedStudentsList.contains(studentList[index])) {
                        markedStudentsList.remove(studentList[index]);
                      } else {
                        markedStudentsList.add(studentList[index]);
                      }
                    });
                  },
                  child: Card(
                    color: getColors(studentList[index]),
                    child: Container(
                      height: 50,
                      width: screenSize.width,
                      alignment: Alignment.center,
                      child: Text(
                        studentList[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: studentList.length),
      ),
      bottomNavigationBar: BlocConsumer<AttandanceBloc, AttandanceState>(
        listener: (context, state) {
          print(state);
          if (state is MarkAttandanceLoaded) {
            Util.buildSuccessSnackBar(context, content: 'Attandance Marked');
            Navigator.of(context).pop();
          }
          if (state is AttandanceError) {
            Util.buildFailedSnackBar(context,
                content: 'Attandance Failed Please Try Again Later.');
          }
        },
        builder: (context, state) {
          if (state is AttandanceLoading) {
            return Util.buildCircularProgressIndicator();
          }
          return Material(
            child: Container(
              height: screenSize.height * 0.1,
              width: screenSize.width,
              color: Colors.white60,
              padding: const EdgeInsets.all(8.0),
              child: DefaultButtonWidget(
                  onTap: () {
                    List<Students> students = [];
                    for (var element in studentList) {
                      bool response = markedStudentsList.contains(element);
                      if (response) {
                        final res =
                            Students(name: element.name, isPresent: true);
                        students.add(res);
                      } else {
                        final res =
                            Students(name: element.name, isPresent: false);
                        students.add(res);
                      }
                    }

                    final attandance = Attandance(
                      date: DateTime.now().toString(),
                      isPresent: true,
                      courseName: widget.course.name,
                      courseCode: widget.course.courseCode,
                    );
                    final classAttandanceModel = ClassAttandanceModel(
                      className: widget.classRoom.name,
                      course: Courses(
                        courseName: widget.course.name,
                        courseCode: widget.course.courseCode,
                        student: students,
                      ),
                    );
                    BlocProvider.of<AttandanceBloc>(context).add(
                      MarkAttandanceEvent(
                        presentStudentsList: markedStudentsList,
                        attandance: attandance,
                        classroom: widget.classRoom,
                        course: widget.course,
                        studentsList: students,
                        classAttandanceModel: classAttandanceModel,
                      ),
                    );
                  },
                  title: 'Mark Attandance',
                  screenSize: screenSize),
            ),
          );
        },
      ),
    );
  }

  Color getColors(Student student) {
    if (markedStudentsList.contains(student)) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
