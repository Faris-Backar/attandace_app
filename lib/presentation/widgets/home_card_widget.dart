import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:flutter/material.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    Key? key,
    required this.screenSize,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final Size screenSize;
  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: StyleResources.primaryColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: screenSize.height * .18,
          width: screenSize.width,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
