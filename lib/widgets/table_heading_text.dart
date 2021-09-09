import 'package:flutter/material.dart';

class TableHeadingText extends StatelessWidget {
  final String? label;
  final TextAlign textAlign;

  const TableHeadingText(
      {Key? key, required this.label, this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        '$label',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
