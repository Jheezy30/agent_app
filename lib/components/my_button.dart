import 'package:agent_app/components/custom_color.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
   MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });





  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color:CustomColors.customColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}