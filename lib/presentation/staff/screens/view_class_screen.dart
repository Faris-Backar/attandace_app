import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/presentation/admin/screens/students_assigned_course_screen.dart';
import 'package:attandance_app/presentation/staff/screens/view_course_attandance_screen.dart';
import 'package:attandance_app/presentation/student/screens/student_course_screen.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:flutter/material.dart';

class ViewClassScreen extends StatefulWidget {
  final ClassRoom classRoom;
  static const routeName = '/ViewClassScreen';
  const ViewClassScreen({Key? key, required this.classRoom}) : super(key: key);

  @override
  State<ViewClassScreen> createState() => _ViewClassScreenState();
}

class _ViewClassScreenState extends State<ViewClassScreen> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final semController = TextEditingController();
  final staffAdvisorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.classRoom.name;
    staffAdvisorController.text = widget.classRoom.staffAdvicer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classRoom.name),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInputFormFieldWidget(
              isEnabled: false,
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
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Courses',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.classRoom.courses.length,
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
                      widget.classRoom.courses[index].name[0].toUpperCase(),
                      style: const TextStyle(
                          color: StyleResources.accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  title: Text(widget.classRoom.courses[index].name),
                  subtitle: Text(widget.classRoom.courses[index].staff!.name),
                  onTap: () => Navigator.of(context).pushNamed(
                      ViewCourseAttandanceScreen.routeName,
                      arguments: [
                        widget.classRoom.courses[index],
                        widget.classRoom.name
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Students',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.classRoom.students.length,
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
                      widget.classRoom.students[index].name[0].toUpperCase(),
                      style: const TextStyle(
                          color: StyleResources.accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  title: Text(widget.classRoom.students[index].name),
                  subtitle:
                      Text(widget.classRoom.students[index].registrationNumber),
                  trailing: Text(widget.classRoom.students[index].department),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        StudentCourseScreen.routeName,
                        arguments: widget.classRoom.students[index].name);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
