import 'package:attandance_app/core/resources/style_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputFormFieldWidget extends StatefulWidget {
  final TextEditingController inputController;
  final TextInputType textInputType;
  final String hintText;
  final String? Function(String?) validatorFunction;
  final String? label;
  final Function(String)? onChanged;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autoFocus;
  final Color? color;
  final bool? isEnabled;
  final int? minLines;
  final int? maxLines;
  final Color? textColor;
  final double? borderRaduis;
  final Widget? prefixButton;
  final Function()? onTap;
  final Widget? suffix;
  const TextInputFormFieldWidget({
    Key? key,
    required this.inputController,
    required this.textInputType,
    required this.hintText,
    required this.validatorFunction,
    this.onChanged,
    this.label,
    this.initialValue,
    this.inputFormatters,
    this.autoFocus,
    this.color,
    this.isEnabled,
    this.minLines,
    this.maxLines,
    this.textColor,
    this.borderRaduis,
    this.prefixButton,
    this.onTap,
    this.suffix,
  }) : super(key: key);

  @override
  State<TextInputFormFieldWidget> createState() =>
      _TextInputFormFieldWidgetState();
}

class _TextInputFormFieldWidgetState extends State<TextInputFormFieldWidget> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      autofocus: widget.autoFocus ?? false,
      inputFormatters: widget.inputFormatters,
      controller: widget.inputController,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      validator: widget.validatorFunction,
      obscureText: isObscure,
      keyboardType: widget.textInputType,
      enabled: widget.isEnabled ?? true,
      minLines: widget.minLines ?? 1,
      maxLines: widget.maxLines ?? 1,
      style: TextStyle(
        fontSize: 14,
        color: widget.isEnabled == false
            ? Colors.grey
            : widget.textColor ?? StyleResources.primaryColor,
      ),
      decoration: InputDecoration(
        prefixIcon: widget.prefixButton,
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: StyleResources.primaryColor,
                ),
              )
            : null,
        filled: true,
        fillColor: StyleResources.accentColor,
        hintText: widget.hintText,
        labelText: widget.label,
        labelStyle:
            TextStyle(color: widget.color ?? StyleResources.primaryColor),
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(.75),
        ),
        suffix: widget.suffix,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.color ?? StyleResources.primaryColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRaduis ?? 5.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.color ?? StyleResources.primaryColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.borderRaduis ?? 5.0,
            ),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: StyleResources.errorColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.color ?? StyleResources.primaryColor, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRaduis ?? 5.0),
          ),
        ),
      ),
      cursorColor: widget.color ?? StyleResources.primaryColor,
      cursorHeight: 22,
    );
  }
}
