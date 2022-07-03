import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.screenSize,
  }) : super(key: key);

  final Function()? onTap;
  final String title;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: StyleResources.primaryColor,
        child: Container(
          height: screenSize.height * .07,
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
