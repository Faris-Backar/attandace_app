import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/model/class_attandance_model.dart';
import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/presentation/bloc/attandance/attandance_bloc.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ViewCourseAttandanceScreen extends StatefulWidget {
  static const routeName = '/ViewCourseAttandanceScreen';
  final Course course;
  final String className;
  const ViewCourseAttandanceScreen(
      {Key? key, required this.course, required this.className})
      : super(key: key);

  @override
  State<ViewCourseAttandanceScreen> createState() =>
      _ViewCourseAttandanceScreenState();
}

class _ViewCourseAttandanceScreenState
    extends State<ViewCourseAttandanceScreen> {
  DateTime? date;

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    BlocProvider.of<AttandanceBloc>(context).add(
      GetIndividualCourseAttandanceEvent(
          courseName: widget.course.name,
          date: DateFormat('dd-MM-yyyy').format(date!),
          className: widget.className),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2030))
                        .then((value) {
                      setState(() {
                        date = value;
                      });
                      BlocProvider.of<AttandanceBloc>(context).add(
                          GetIndividualCourseAttandanceEvent(
                              courseName: widget.course.name,
                              date: DateFormat('dd-MM-yyyy').format(date!),
                              className: widget.className));
                      print(DateFormat('dd-MM-yyyy').format(date!));
                    });
                  },
                  child: Row(
                    children: [
                      Text('Date : ${DateFormat('dd-MMM-yyyy').format(date!)}'),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AttandanceBloc, AttandanceState>(
            builder: (context, state) {
              if (state is AttandanceLoading) {
                return Util.buildCircularProgressIndicator();
              }
              if (state is IndividualCourseAttandanceLoaded) {
                var classAttandance = state.classAttandance;
                List<ClassAttandanceModel> attandanceList = classAttandance;
                if (classAttandance.isEmpty) {
                  return Center(
                    child: Text(
                        'No Data is found for date ${DateFormat('dd-MMM-yyyy').format(date!)}'),
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Status',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Divider(),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var classroom = classAttandance[index];
                          print(classroom.course);
                          return Column(
                            children: [
                              Text(
                                'Period ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, i) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(classroom.course.student[i].name),
                                    Text(
                                      classroom.course.student[i].isPresent ==
                                              true
                                          ? 'Present'
                                          : 'Absent',
                                      style: TextStyle(
                                        color: classroom.course.student[i]
                                                    .isPresent ==
                                                true
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 30,
                                ),
                                itemCount: classroom.course.student.length,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: classAttandance.length)
                  ],
                );
              }
              return Container();
            },
          )
        ]),
      ),
    );
  }
}
