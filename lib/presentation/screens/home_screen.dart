import 'package:attandance_app/core/config/config.dart';
import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:attandance_app/presentation/screens/login_screen.dart';
import 'package:attandance_app/presentation/widgets/home_card_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Config.screenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attandance Screen',
        ),
        backgroundColor: StyleResources.primaryColor,
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: Config.defaultPadding(),
        child: Column(
          children: [
            HomeCardWidget(
              screenSize: screenSize,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(LogInScreen.routeName, arguments: 'Admin');
              },
              title: 'Admin',
            ),
            const SizedBox(
              height: 10,
            ),
            HomeCardWidget(
              screenSize: screenSize,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(LogInScreen.routeName, arguments: 'Staff');
              },
              title: 'Staff',
            ),
            const SizedBox(
              height: 10,
            ),
            HomeCardWidget(
              screenSize: screenSize,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(LogInScreen.routeName, arguments: 'Student');
              },
              title: 'Student',
            ),
          ],
        ),
      ),
    );
  }
}
