import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:flutter/material.dart';

class DropDownFieldWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? hintText;
  final List<String> item;
  final Function(String?)? onChanged;

  const DropDownFieldWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.item,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      alignment: Alignment.center,
      enableFeedback: true,
      decoration: InputDecoration(
        label: Text(title),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: StyleResources.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: StyleResources.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: StyleResources.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        labelStyle: TextStyle(color: StyleResources.primaryColor),
      ),
      value: value,
      hint: Text(hintText ?? ''),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: item.map((String branches) {
        return DropdownMenuItem(
          value: branches,
          child: Text(branches),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
