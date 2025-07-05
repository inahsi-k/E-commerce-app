import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextformfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final int lines;
  final void Function(String?) onSave;
  final String? Function(String?)? validator;
  const CustomTextformfield({super.key, required this.hintText, required this.controller, required this.inputType, required this.lines, required this.onSave, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white), 
      ),
      maxLines: lines,
      controller: controller,
      keyboardType:inputType ,
      validator: validator,
      onSaved: (value) {
          onSave(value?.isEmpty ?? true ? null : value);
      },
      inputFormatters: [
          LengthLimitingTextInputFormatter(700),
          if (inputType == TextInputType.number) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
      ],

    );
  }
}
