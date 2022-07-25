import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:flutter/material.dart';

class AdminCardWidget extends StatelessWidget {
  const AdminCardWidget({
    Key? key,
    required this.screenSize,
    required this.label,
    required this.ontap,
  }) : super(key: key);

  final Size screenSize;
  final Function()? ontap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 5.0,
        color: StyleResources.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: screenSize.height * 0.15,
          width: screenSize.width,
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
