// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFaild extends StatelessWidget {
  CustomTextFaild({
    super.key,
    this.hintText,
    this.inputType,
    this.onchange,
    this.obscureText,
  });
  Function(String)? onchange;
  String? hintText;
  bool? obscureText;
  TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText!,
      onChanged: onchange,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(16)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(16))),
    );
  }
}
