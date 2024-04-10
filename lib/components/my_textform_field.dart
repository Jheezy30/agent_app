import 'package:flutter/material.dart';


class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isRequired;
  final bool isNumericOnly;
  final bool isObsecureText;
  final String? Function(String?)? validator;

  const MyTextFormField({
    super.key, 
    required this.controller,
    required this.labelText,
    this.isRequired = false,
    this.isNumericOnly = false,
    this.isObsecureText = false,
     this.validator,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: isObsecureText,
        style: TextStyle(color: Colors.grey.shade900),
        keyboardType: isNumericOnly ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: isRequired ? '$labelText* ' : labelText,
          labelStyle: TextStyle(
             color:Colors.grey.shade900,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isRequired ? Colors.red : Colors.grey.shade500,
            ),
          ),
        ),
        cursorColor: Colors.grey.shade900,
        validator: validator ?? (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'This field is required';
          }

          return null;
        },
      ),
    );
  }
}