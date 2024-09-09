import 'package:flutter/material.dart';

class HomeChip extends StatelessWidget {
  final String text;
  final Color? color;
  const HomeChip({
    required this.text,
    this.color,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Text(text),
      ),
      color: color??Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(width: 0.1)),
    );
  }
}