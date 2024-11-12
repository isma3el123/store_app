import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.color,
      required this.text,
      required this.ontap});
  final Color color;
  VoidCallback? ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
