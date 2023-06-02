import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.onTap,
      required this.title,
      required this.color,
      this.width = double.infinity,
      this.borderRadius = 0.0});
  final VoidCallback onTap;
  final String title;
  final Color color;
  final double width;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(width, 50)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
          elevation: MaterialStateProperty.all(0.5)),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600),
      ),
    );
  }
}
