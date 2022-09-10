import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController Controller;
  final TextInputType textInputType;
  final String? hintText;
  final bool isPhone;
  final bool isPassWord;
  final Widget suffixIcon;
  final Widget? prefix;
  final VoidCallback? onTaped;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextStyle? style;
  final TextStyle? hintStyle;
  MyFormField({
    required this.Controller,
    required this.textInputType,
    required this.hintText,
    this.isPhone = false,
    this.isPassWord = false,
    this.suffixIcon =
        const Icon(Icons.remove_red_eye_outlined, color: Colors.black),
    required this.prefix,
    this.onTaped,
    this.onChanged,
    this.onFieldSubmitted,
    this.style,
    this.hintStyle
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      keyboardType: textInputType,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTap: onTaped,

      style: style,
      decoration: InputDecoration(
        prefixIcon: prefix,
        hintText: '$hintText',
        hintStyle:hintStyle,

        suffixIcon: isPassWord ? suffixIcon : const SizedBox.shrink(),
        contentPadding: const EdgeInsets.all(20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
