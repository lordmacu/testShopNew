import 'package:flutter/material.dart';

class TextFieldW extends StatelessWidget {
  const TextFieldW(
      {Key key,
      this.hint,
      this.onChanged,
      this.isPassword,
      this.validator,
      this.autovalidate});

  final String hint;
  final Function onChanged;
  final Function validator;
  final bool isPassword;
  final AutovalidateMode autovalidate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidate,
      validator: validator,
      onChanged: onChanged,
      obscureText: isPassword,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
