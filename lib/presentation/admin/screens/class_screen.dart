import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:flutter/material.dart';

class ClassScreen extends StatelessWidget {
  static const routeName = '/ClassScreen';
  const ClassScreen({Key? key}) : super(key: key);

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded))
        ],
      ),
    );
  }
}
