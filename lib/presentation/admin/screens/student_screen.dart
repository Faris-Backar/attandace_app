import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/admin/screens/create_student_screen.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/widgets/slidable_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentScreen extends StatefulWidget {
  static const routeName = '/StudentsScreen';
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<Student> studentList = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentBloc>(context).add(GetStudentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Student',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CreateStudentScreen.routeName);
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
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
            if (state is CreateStudentLoaded) {
              BlocProvider.of<StudentBloc>(context).add(GetStudentEvent());
            }
            if (state is GetStudentLoaded) {
              studentList = state.studentList;
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
                  shrinkWrap: true,
                  itemCount: studentList.length,
                  itemBuilder: (context, index) => SlidableActionWidget(
                        index: index,
                        ontap: () async {
                          BlocProvider.of<StudentBloc>(context).add(
                            DeleteStudentEvent(
                                username: studentList[index].name),
                          );
                          Navigator.of(context).pop();
                          BlocProvider.of<StudentBloc>(context)
                              .add(GetStudentEvent());
                        },
                        child: Card(
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
                              Navigator.of(context).pushNamed(
                                  CreateStudentScreen.routeName,
                                  arguments: [studentList[index], index]);
                            },
                          ),
                        ),
                      ));
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
    );
  }
}
