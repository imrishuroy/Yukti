import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String label;
  final IconData icon;

  const TabItem({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
