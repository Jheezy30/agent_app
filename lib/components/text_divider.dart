import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const TextDivider({
    required this.text,
    this.width = double.infinity,
    this.height = 1,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: textStyle,
          ),
          Divider(
            color: Colors.grey.shade500,
            height: height,
          ),
        ],
      ),
    );
  }
}