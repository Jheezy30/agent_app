import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final String hintText;
  final void Function(String?)? onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;

  const MyDropDownButton({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hintText,
    this.isRequired = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 65,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: selectedValue.isNotEmpty && items.contains(selectedValue)
            ? selectedValue
            : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        hint: Text(hintText, style: TextStyle(color: Colors.grey.shade900)),
        onChanged: onChanged,
        items: items
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
                ),
              ),
            )
            .toList(),
        style: TextStyle(color: Colors.grey.shade100),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey.shade900,
        ),
        validator: validator ??
            (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
      ),
    );
  }
}
