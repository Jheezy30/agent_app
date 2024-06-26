import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isRequired;
  final bool isNumericOnly;
  final bool isObsecureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const MyTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isRequired = false,
    this.isNumericOnly = false,
    this.isObsecureText = false,
    this.validator,
    this.onSaved,
  }) : super(key: key);

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
            color: Colors.grey.shade900,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isRequired ? Colors.red : Colors.grey.shade500,
            ),
          ),
        ),
        cursorColor: Colors.grey.shade900,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'This field is required';
          }

          if (isNumericOnly && value != null && value.isNotEmpty) {
            if (value.length < 10) {
              return 'Digit is not up to 10';
            }
          }

          return validator != null ? validator!(value) : null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
