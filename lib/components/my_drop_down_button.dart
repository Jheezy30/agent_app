import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final void Function(String?)? onChanged;

  const MyDropDownButton({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade500),
        ),

        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              isExpanded: true,

              value: selectedValue,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade900,
                    ),
                    ),
                );

              }).toList(),

              style: TextStyle(color: Colors.grey.shade900,

              ),
              icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: Colors.grey.shade100,
              dropdownColor: Colors.grey.shade100,
            ),
          ),
        ),
      ),
    );
  }
}