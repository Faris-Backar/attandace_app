import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/model/classroom.dart';
import 'package:attandance_app/presentation/admin/screens/create_class_room_screen.dart';
import 'package:attandance_app/presentation/bloc/classroom/classroom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassScreen extends StatefulWidget {
  static const routeName = '/ClassScreen';
  const ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  List<ClassRoom> classRoomList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassroomBloc>(context).add(GetClassRoomEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Class',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(CreateClassRoomScreen.routeName);
              },
              icon: const Icon(Icons.add_rounded))
        ],
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: BlocBuilder<ClassroomBloc, ClassroomState>(
          builder: (context, state) {
            if (state is ClassroomLoading) {
              return Center(
                child: CircularProgressIndicator(
                    color: StyleResources.primaryColor),
              );
            }
            if (state is ClassRoomLoaded) {
              classRoomList = state.classroomList;
              if (classRoomList.isEmpty) {
                return const Center(
                  child: Text(
                    'No Class Rooms Founds',
                    style: TextStyle(
                      color: Colors.black,
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
                itemCount: classRoomList.length,
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
                        classRoomList[index].name[0].toUpperCase() +
                            classRoomList[index].name[1].toUpperCase(),
                        style: const TextStyle(
                            color: StyleResources.accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    title: Text(
                      classRoomList[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(classRoomList[index].staffAdvicer),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                      onPressed: () {},
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        CreateClassRoomScreen.routeName,
                        arguments: classRoomList[index],
                      );
                    },
                  ),
                ),
              );
            }
            return const Center(
              child: Text(
                'No Class Rooms Founds',
                style: TextStyle(
                  color: Colors.black,
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
