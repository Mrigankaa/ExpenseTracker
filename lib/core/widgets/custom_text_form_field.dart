import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final bool? readeOnly;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  CustomTextFormField({
    this.readeOnly, 
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readeOnly??false,
      obscureText: obscureText,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? suffixIcon : null,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.teal,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}