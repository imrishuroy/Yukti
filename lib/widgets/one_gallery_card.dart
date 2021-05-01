import 'package:flutter/material.dart';

class OneGalleryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const OneGalleryCard({
    Key? key,
    this.label: 'Campus Tour',
    this.icon: Icons.map,
    this.color: Colors.yellow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: color,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SizedBox(
              height: 70.0,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 30.0),
                  SizedBox(height: 7.0),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
