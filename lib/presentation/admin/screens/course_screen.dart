import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/presentation/bloc/admin/admin_bloc.dart';
import 'package:attandance_app/presentation/widgets/default_button_widget.dart';
import 'package:attandance_app/presentation/widgets/text_input_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseScreen extends StatefulWidget {
  static const routeName = '/CourseScreen';
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final courseCodeController = TextEditingController();
  List<Course> courseList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminBloc>(context).add(GetCourseEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Course',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: Config.defaultPadding(),
                  child: SizedBox(
                    height: 250,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextInputFormFieldWidget(
                            inputController: nameController,
                            textInputType: TextInputType.text,
                            hintText: '',
                            validatorFunction: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter a valid name';
                              }
                              return null;
                            },
                            label: 'Name',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextInputFormFieldWidget(
                            inputController: courseCodeController,
                            textInputType: TextInputType.text,
                            hintText: '',
                            validatorFunction: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter a valid course Code';
                              }
                              return null;
                            },
                            label: 'Course Code',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultButtonWidget(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                final course = Course(
                                    name: nameController.text,
                                    courseCode: courseCodeController.text);
                                BlocProvider.of<AdminBloc>(context)
                                    .add(CreateCourseEvent(course: course));
                                BlocProvider.of<AdminBloc>(context)
                                    .add(GetCourseEvent());
                                nameController.clear();
                                courseCodeController.clear();
                                Navigator.of(context).pop();
                              }
                            },
                            title: 'Create Course',
                            screenSize: screenSize,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is GetCourseLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: StyleResources.primaryColor,
                ),
              );
            }
            if (state is GetCourseLoaded) {
              courseList = state.courseList;
              if (courseList.isEmpty) {
                return const Center(
                  child: Text(
                    'No Course Found',
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
                itemCount: courseList.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey[200],
                  elevation: 5.0,
                  child: ListTile(
                    // onTap: () => Navigator.of(context).pushNamed(
                    //   CreateStaffScreen.routeName,
                    //   arguments: 'Update',
                    // ),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: StyleResources.primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        courseList[index].name[0].toUpperCase(),
                        style: const TextStyle(
                            color: StyleResources.accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    title: Text(
                      courseList[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(courseList[index].courseCode),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: Text(
                'No Course Found',
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
