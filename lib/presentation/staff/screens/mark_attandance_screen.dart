import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarkAttandanceScreen extends StatefulWidget {
  static const routeName = '/MarkAttandanceScreen';
  final List<Student> students;
  const MarkAttandanceScreen({Key? key, required this.students})
      : super(key: key);

  @override
  State<MarkAttandanceScreen> createState() => _MarkAttandanceScreenState();
}

class _MarkAttandanceScreenState extends State<MarkAttandanceScreen> {
  List<Student> markedStudentsList = [];
  bool checkedValue = false;

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
                      if (markedStudentsList.contains(widget.students[index])) {
                        markedStudentsList.remove(widget.students[index]);
                      } else {
                        markedStudentsList.add(widget.students[index]);
                      }
                    });
                  },
                  child: Card(
                    color: getColors(widget.students[index]),
                    child: Container(
                      height: 50,
                      width: screenSize.width,
                      alignment: Alignment.center,
                      child: Text(
                        widget.students[index].name,
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
            itemCount: widget.students.length),
      ),
      bottomNavigationBar: Material(
        child: Container(
          height: screenSize.height * 0.1,
          width: screenSize.width,
          color: Colors.white60,
          padding: const EdgeInsets.all(8.0),
          child: DefaultButtonWidget(
              onTap: () {
                
              }, title: 'Mark Attandance', screenSize: screenSize),
        ),
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
