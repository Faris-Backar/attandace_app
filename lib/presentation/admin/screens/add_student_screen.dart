import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/admin/screens/create_student_screen.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStudentScreen extends StatefulWidget {
  final String semester;
  static const routeName = '/AddStudentScreen';
  const AddStudentScreen({Key? key, required this.semester}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<AddStudentScreen> {
  List<Student> studentList = [];
  List<Student> selectedList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentBloc>(context).add(GetStudentEvent());
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<StudentBloc>(context).add(GetStudentEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Student',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            if (state is StudentLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }

            if (state is GetStudentLoaded) {
              List<Student> students = state.studentList;
              studentList = students
                  .where((student) => student.semester == widget.semester)
                  .toList();
              if (studentList.isEmpty) {
                return const Center(
                  child: Text(
                    'No Students Found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: studentList.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey[200],
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
                        studentList[index].name[0].toUpperCase(),
                        style: const TextStyle(
                            color: StyleResources.accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    title: Text(
                      studentList[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                        '${studentList[index].semester} ${studentList[index].department}'),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                      onPressed: () {},
                    ),
                    onTap: () {
                      setState(() {
                        selectedList.add(studentList[index]);
                        studentList.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            }
            return const Center(
              child: Text(
                'No Student Found',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 50.0,
        child: Container(
          height: screenSize.height * .1,
          width: screenSize.width,
          padding: Config.defaultPadding(),
          alignment: Alignment.center,
          child: DefaultButtonWidget(
            onTap: () {
              BlocProvider.of<ClassroomBloc>(context)
                  .add(AddClassRoomStudentsEvent(studentsList: selectedList));
              Navigator.of(context).pop();
            },
            title: "Add Selected Students",
            screenSize: screenSize,
          ),
        ),
      ),
    );
  }
}
