import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
//  final String? count;
  final Function? onTap;

  const OptionCard({
    Key? key,
    this.title,
    this.icon,
    //  this.count,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap as void Function()?,
      child: Card(
        // color: Color.fromRGBO(255, 255, 250, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height < 750 ? 20.0 : 30.0),
            Icon(icon, size: height < 750 ? 30.0 : 40),
            const SizedBox(height: 12.0),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: height < 750 ? 15.0 : 30.0),
          ],
        ),
      ),
    );
  }
}
