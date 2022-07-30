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
                      GetIndividualCourseAttandanceEvent(
                          courseName: widget.course.name,
                          date: DateFormat('dd-MM-yyyy').format(date!),
                          className: widget.className);
                    });
                  },
                  child: Text(
                      'Date : ${DateFormat('dd-MMM-yyyy').format(date!)}')),
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

                // return DataTable(
                //   columns: const [
                //     DataColumn(
                //       label: Text('Name'),
                //     ),
                //     DataColumn(
                //       label: Text('Present'),
                //     ),
                //   ],
                //   // rows: attandanceList.map((e) {
                //   //   int i = 0;

                //   //   return DataRow(cells: [
                //   //     DataCell(
                //   //       Text(e.course.student[i++].name),
                //   //     ),
                //   //     DataCell(Text(e.course.student[i++].isPresent == true
                //   //         ? 'Present'
                //   //         : 'Absent')),
                //   //   ]);
                //   // }).toList(),
                //   rows: [
                //     // for (var index = 0;
                //     //     index <= classAttandance.length;
                //     //     index++)
                //     for (int i = 0;
                //         i <= classAttandance[0].course.student.length;
                //         i++)
                //       DataRow(cells: [
                //         DataCell(
                //           Text(classAttandance[0].course.student[i].name),
                //         ),
                //         DataCell(Text(
                //             classAttandance[0].course.student[i].isPresent ==
                //                     true
                //                 ? 'Present'
                //                 : 'Absent')),
                //       ]),
                //   ],
                // );
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
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Period $index',
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
                                          classroom.course.student[index]
                                                      .isPresent ==
                                                  true
                                              ? 'Present'
                                              : 'Absent',
                                          style: TextStyle(
                                            color: classroom
                                                        .course
                                                        .student[index]
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
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: classAttandance[0].course.student.length)
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
