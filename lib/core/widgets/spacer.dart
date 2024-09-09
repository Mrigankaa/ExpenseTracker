import 'package:flutter/material.dart';

class ETSpacer extends StatelessWidget {
  final double? height;
  const ETSpacer({super.key,required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height??10.0,);
  }
}