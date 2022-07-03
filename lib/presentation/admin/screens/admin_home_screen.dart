import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/admin/widgets/admin_drawer_widget.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = 'AdminHomeScreen';
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleResources.primaryColor,
        title: const Text(
          'Home',
          style: TextStyle(
            color: StyleResources.accentColor,
          ),
        ),
      ),
      drawer: AdminDrawerWidget(screenSize: screenSize),
    );
  }
}
