import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:flutter/material.dart';

class Util {
  static buildSuccessSnackBar(BuildContext context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static buildFailedSnackBar(BuildContext context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: StyleResources.errorColor,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: StyleResources.primaryColor,
      ),
    );
  }
}
