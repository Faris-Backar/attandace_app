import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/admin/screens/admin_home_screen.dart';
import 'package:attandance_app/presentation/admin/screens/class_screen.dart';
import 'package:attandance_app/presentation/admin/screens/course_screen.dart';
import 'package:attandance_app/presentation/admin/screens/staff_screen.dart';
import 'package:flutter/material.dart';

class AdminDrawerWidget extends StatefulWidget {
  const AdminDrawerWidget({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  State<AdminDrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<AdminDrawerWidget> {
  List drawerListMenu = [
    {
      'leading': const Icon(
        Icons.class_outlined,
        color: Colors.white,
      ),
      'title': 'Course',
      'navigation': CourseScreen.routeName,
      'trailing': const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
    },
    {
      'leading': const Icon(
        Icons.person,
        color: Colors.white,
      ),
      'title': 'Staff',
      'navigation': StaffScreen.routeName,
      'trailing': const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
    },
    {
      'leading': const Icon(
        Icons.bookmark_outline,
        color: Colors.white,
      ),
      'title': 'Class',
      'navigation': ClassScreen.routeName,
      'trailing': const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: StyleResources.primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(child: Container()),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                leading: drawerListMenu[index]['leading'],
                title: Text(
                  drawerListMenu[index]['title'],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(drawerListMenu[index]['navigation']);
                },
                trailing: drawerListMenu[index]['trailing'],
              ),
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white,
                endIndent: 20,
                indent: 20,
              ),
              itemCount: drawerListMenu.length,
            ),
          ],
        ),
      ),
    );
  }
}
