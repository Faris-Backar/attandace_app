import 'dart:developer';

import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/model/student.dart';
import 'package:attandance_app/presentation/admin/widgets/drop_down_widget.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:attandance_app/presentation/bloc/staff/staff_bloc.dart';
import 'package:attandance_app/presentation/bloc/student/student_bloc.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CreateClassRoomScreen extends StatefulWidget {
  final ClassRoom? classRoom;
  static const routeName = '/CreateClassRoomScreen';
  const CreateClassRoomScreen({Key? key, this.classRoom}) : super(key: key);

  @override
  State<CreateClassRoomScreen> createState() => _CreateClassRoomState();
}

class _CreateClassRoomState extends State<CreateClassRoomScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  List<String> subject = [];
  List<String> staff = [];
  List<String> staffAdvisor = [];
  List<String> courseList = [];
  List<Course> selectedcourseList = [];
  List<Student> students = [];
  String branchValue = 'CSE';
  String? courseValue;
  String subjectValue = '';
  String staffValue = '';
  String staffAdvisorValue = '';
  List<Course> subjectList = [];
  List<Staff> staffSelectedList = [];
  Staff? selectedStaff;
  var semester = [
    'S1',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'S7',
    'S8',
  ];
  var branches = [
    'CSE',
    'CE',
    'ECE',
    'EEE',
    'ME',
  ];
  String semValue = 'S1';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminBloc>(context).add(GetCourseEvent());
    BlocProvider.of<StaffBloc>(context).add(GetStaffEvent());
    BlocProvider.of<StudentBloc>(context).add(GetStudentEvent());
    BlocProvider.of<StudentBloc>(context).add(
        GetFilteredStudentsAccordingtoSemester(
            semester: semValue, branch: branchValue));
    BlocProvider.of<StudentBloc>(context).add(GetStudentEvent());
    BlocProvider.of<StudentBloc>(context).add(
      GetFilteredStudentsAccordingtoSemester(
          semester: semValue, branch: branchValue),
    );
    BlocProvider.of<ClassroomBloc>(context).add(GetClassRoomStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: Text(
          widget.classRoom != null
              ? widget.classRoom!.name
              : 'Create Class Room',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<ClassroomBloc>(context)
                .add(GetClassRoomStudentsEvent());
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: SingleChildScrollView(
          child: widget.classRoom == null
              ? Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextInputFormFieldWidget(
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
                      const SizedBox(height: 20),
                      DropDownFieldWidget(
                          title: 'Semester',
                          value: semValue,
                          item: semester,
                          onChanged: (value) {
                            setState(() {
                              semValue = value!;
                              BlocProvider.of<StudentBloc>(context).add(
                                  GetFilteredStudentsAccordingtoSemester(
                                      semester: semValue, branch: branchValue));
                            });
                          }),
                      const SizedBox(height: 20),
                      DropDownFieldWidget(
                          title: 'Branch',
                          value: branchValue,
                          item: branches,
                          onChanged: (newValue) {
                            setState(() {
                              branchValue = newValue!;
                            });
                            BlocProvider.of<StudentBloc>(context).add(
                                GetFilteredStudentsAccordingtoSemester(
                                    semester: semValue, branch: branchValue));
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<StaffBloc, StaffState>(
                        builder: (context, state) {
                          if (state is StaffLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: StyleResources.primaryColor,
                              ),
                            );
                          }
                          if (state is GetStaffLoaded) {
                            staffAdvisor.clear();
                            for (var i = 0; i < state.staffList.length; i++) {
                              staffAdvisor.add(state.staffList[i].name);
                            }
                            if (staffAdvisorValue == '') {
                              staffAdvisorValue = staffAdvisor[0];
                            }
                            // selectedStaff = state.staffList.singleWhere(
                            //     (element) =>
                            //         element.name.contains(staffAdvisorValue));

                            log(staffAdvisor.toString());
                            return DropDownFieldWidget(
                                title: 'Staff Advisor',
                                value: staffAdvisorValue,
                                item: staffAdvisor,
                                onChanged: (value) {
                                  setState(() {
                                    staffAdvisorValue = value!;
                                  });
                                });
                          }
                          return Container();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subjects',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<AdminBloc>(context)
                                    .add(GetCourseEvent());

                                Course course;
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey),
                                        ),
                                        BlocBuilder<AdminBloc, AdminState>(
                                          builder: (context, state) {
                                            if (state is GetCourseLoading) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: StyleResources
                                                            .primaryColor),
                                              );
                                            }
                                            if (state is GetCourseLoaded) {
                                              subjectList = state.courseList;
                                              courseList.clear();
                                              for (var i = 0;
                                                  i < state.courseList.length;
                                                  i++) {
                                                courseList.add(
                                                    state.courseList[i].name);
                                              }
                                              log(courseList.toString());
                                              courseValue = courseList[0];
                                              return DropDownFieldWidget(
                                                  title: 'Course',
                                                  value: courseValue!,
                                                  item: courseList,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      courseValue = value!;
                                                    });
                                                  });
                                            }
                                            return Container();
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        BlocBuilder<StaffBloc, StaffState>(
                                          builder: (context, state) {
                                            if (state is StaffLoading) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: StyleResources
                                                      .primaryColor,
                                                ),
                                              );
                                            }
                                            if (state is GetStaffLoaded) {
                                              staffSelectedList =
                                                  state.staffList;
                                              staff.clear();
                                              for (var i = 0;
                                                  i < state.staffList.length;
                                                  i++) {
                                                staff.add(
                                                    state.staffList[i].name);
                                              }
                                              staffValue = staff[0];
                                              log(staff.toString());
                                              return DropDownFieldWidget(
                                                  title: 'Staff',
                                                  value: staffValue,
                                                  item: staff,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      staffValue = value!;
                                                    });
                                                    log(staffValue);
                                                  });
                                            }
                                            return Container();
                                          },
                                        ),
                                        DefaultButtonWidget(
                                            onTap: () {
                                              course = subjectList.singleWhere(
                                                  (course) =>
                                                      course.name ==
                                                      courseValue);
                                              final staffSelected =
                                                  staffSelectedList.singleWhere(
                                                      (element) =>
                                                          element.name ==
                                                          staffValue);
                                              final createdCourse = Course(
                                                  totalHoursTaken: '0',
                                                  name: course.name,
                                                  courseCode: course.courseCode,
                                                  staff: staffSelected);
                                              log('Created Course=> $createdCourse');
                                              setState(() {
                                                selectedcourseList
                                                    .add(createdCourse);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            title: 'Create Subject',
                                            screenSize: screenSize)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_outlined)),
                        ],
                      ),
                      BlocBuilder<AdminBloc, AdminState>(
                        builder: (context, state) {
                          if (state is GetCourseLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: StyleResources.primaryColor,
                              ),
                            );
                          }
                          if (state is GetCourseLoaded) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: selectedcourseList.length,
                              itemBuilder: (context, index) =>
                                  _buildSlidableAction(
                                      child: Card(
                                        elevation: 5.0,
                                        child: ListTile(
                                          leading: Text(
                                              selectedcourseList[index]
                                                  .courseCode),
                                          title: Text(
                                              selectedcourseList[index].name),
                                          subtitle: Text(
                                              selectedcourseList[index]
                                                  .staff!
                                                  .name),
                                        ),
                                      ),
                                      index: index,
                                      ontap: () {
                                        BlocProvider.of<ClassroomBloc>(context)
                                            .add(
                                          DeleteClassRoomStudentsEvent(
                                            course: selectedcourseList[index],
                                          ),
                                        );
                                      }),
                            );
                          }
                          return const Center(
                            child: Text(
                              'No Student is Selected',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Students',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<StudentBloc, StudentState>(
                        builder: (context, state) {
                          if (State is StudentLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: StyleResources.primaryColor,
                              ),
                            );
                          }
                          if (state is GetStudentLoaded) {
                            students = state.studentList;

                            if (students.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No Student is Selected',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: students.length,
                              itemBuilder: (context, index) => Card(
                                elevation: 5.0,
                                child: _buildSlidableAction(
                                  index: index,
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
                                        students[index].name[0].toUpperCase(),
                                        style: const TextStyle(
                                            color: StyleResources.accentColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    title: Text(students[index].name),
                                    subtitle: Text(
                                        students[index].registrationNumber),
                                    trailing: Text(students[index].department),
                                  ),
                                  ontap: () {
                                    setState(() {
                                      BlocProvider.of<StudentBloc>(context).add(
                                        DeleteFilteredStudentsAccordingtoSemester(
                                          student: students[index],
                                        ),
                                      );
                                    });

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: Text(
                              'No Student is Selected',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<ClassroomBloc, ClassroomState>(
                        listener: (context, state) {
                          if (state is CreateClassroomLoaded) {
                            Util.buildSuccessSnackBar(context,
                                content:
                                    'You are Successfully Created classroom ${nameController.text}');
                            BlocProvider.of<ClassroomBloc>(context)
                                .add(GetClassRoomEvent());
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          if (state is ClassroomLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: StyleResources.primaryColor),
                            );
                          }
                          if (state is ClassRoomError) {
                            return Util.buildFailedSnackBar(
                              context,
                              content:
                                  'Something went wrong please try again later.',
                            );
                          }

                          return DefaultButtonWidget(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  final classroom = ClassRoom(
                                    name: nameController.text,
                                    staffAdvicer: staffAdvisorValue,
                                    students: students,
                                    courses: selectedcourseList,
                                  );
                                  BlocProvider.of<ClassroomBloc>(context).add(
                                    CreateClassRoomEvent(
                                      classRoom: classroom,
                                    ),
                                  );
                                }
                              },
                              title: 'Create ClassRoom',
                              screenSize: screenSize);
                        },
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subjects',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.classRoom!.courses.length,
                      itemBuilder: (context, index) => _buildSlidableAction(
                          child: Card(
                            elevation: 5.0,
                            child: ListTile(
                              onTap: () {},
                              leading: Text(
                                  widget.classRoom!.courses[index].courseCode),
                              title:
                                  Text(widget.classRoom!.courses[index].name),
                              subtitle: Text(
                                  widget.classRoom!.courses[index].staff!.name),
                            ),
                          ),
                          index: index,
                          ontap: () {
                            BlocProvider.of<ClassroomBloc>(context).add(
                              DeleteClassRoomStudentsEvent(
                                course: widget.classRoom!.courses[index],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Students',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.classRoom!.students.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 5.0,
                        child: _buildSlidableAction(
                          index: index,
                          child: ListTile(
                            onTap: () {},
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: StyleResources.primaryColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                widget.classRoom!.students[index].name[0]
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: StyleResources.accentColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            title: Text(widget.classRoom!.students[index].name),
                            subtitle: Text(widget
                                .classRoom!.students[index].registrationNumber),
                            trailing: Text(
                                widget.classRoom!.students[index].department),
                          ),
                          ontap: () {
                            setState(() {
                              BlocProvider.of<StudentBloc>(context).add(
                                DeleteFilteredStudentsAccordingtoSemester(
                                  student: widget.classRoom!.students[index],
                                ),
                              );
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Slidable _buildSlidableAction(
      {required int index, required Widget child, required Function()? ontap}) {
    return Slidable(
        key: ValueKey(index),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: .3,
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    actions: [
                      MaterialButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      // ElevatedButtonTheme(
                      //   data: ElevatedButtonThemeData(
                      //     style: ButtonStyle(foregroundColor: )
                      //   ),
                      //   child:
                      ElevatedButton(
                        onPressed: ontap,
                        child: const Text('Delete'),
                      ),
                      // ),
                    ],
                    content: const Text(
                      'Press Delete button to confirm your action',
                    ),
                  ),
                );
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: child);
  }
}
