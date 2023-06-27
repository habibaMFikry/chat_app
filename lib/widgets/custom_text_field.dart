import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({Key? key, this.hintText, this.onChanged , this.obscureText =false}) : super(key: key);
  final Function(String)? onChanged;
  final String? hintText;

 final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }else{return null;}
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
