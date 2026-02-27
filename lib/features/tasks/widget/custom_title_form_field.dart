import 'package:flutter/material.dart';

class CustomTitleFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? errorText;
  final IconData prefixIcon;
  final Function(String)? onChanged;
  final int maxLines;
  const CustomTitleFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
    required this.maxLines,
    this.onChanged,
    this.focusNode,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      maxLines: maxLines,
      showCursor: true,
      cursorErrorColor: Colors.red,
      cursorRadius: Radius.circular(4),
      cursorWidth: 3.0,
      cursorColor: Colors.black87,
      textInputAction: TextInputAction.done,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
      ),
      onTapOutside: (event) {
        focusNode!.unfocus();
      },
      decoration: InputDecoration(
        errorText: errorText,
        errorStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: const Color.fromARGB(255, 134, 9, 9),
        ),
        visualDensity: VisualDensity.compact,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8.5,
          vertical: 18.5,
        ),
        prefixIcon: Icon(prefixIcon, size: 29.5),
        prefixIconColor: Colors.black87,
        filled: true,
        fillColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.black87,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
