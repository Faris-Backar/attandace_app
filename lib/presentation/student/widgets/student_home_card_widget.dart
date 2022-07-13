import 'package:flutter/material.dart';

class StudentHomeCardWidget extends StatelessWidget {
  const StudentHomeCardWidget({
    Key? key,
    required this.screenSize,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final Size screenSize;
  final Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: screenSize.height * .1,
        width: screenSize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
