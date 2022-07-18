import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/pref_resources.dart';
import 'package:attandance_app/main.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:attandance_app/presentation/staff/screens/view_class_screen.dart';
import 'package:attandance_app/presentation/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAssignedClassScreen extends StatelessWidget {
  static const routeName = '/ViewAssignedCoursesScreen';
  const ViewAssignedClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ClassroomBloc>(context).add(GetClassRoomEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Classes'),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocBuilder<ClassroomBloc, ClassroomState>(
          builder: (context, state) {
            if (state is ClassroomLoading) {
              return Util.buildCircularProgressIndicator();
            }
            if (state is ClassRoomLoaded) {
              List<ClassRoom> classroom = state.classroomList;
              List<ClassRoom> selectedClassRoom = classroom
                  .where(
                    (e) => e.staffAdvicer
                        .contains(prefs.getString(PrefResources.USERNAME)!),
                  )
                  .toList();
              if (selectedClassRoom.isEmpty) {
                return const Center(
                  child: Text(
                    'No Classes Assigned For you',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                );
              }
              return ListView.builder(
                itemCount: selectedClassRoom.length,
                itemBuilder: (context, index) => Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(selectedClassRoom[index].name),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ViewClassScreen.routeName,
                        arguments: selectedClassRoom[index],
                      );
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
