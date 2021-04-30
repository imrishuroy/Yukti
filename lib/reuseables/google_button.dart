import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;

  const GoogleSignInButton({
    Key? key,
    @required this.onPressed,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 46.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  child: Image.asset('assets/google.png'),
                ),
              ),
              SizedBox(width: 10.0),
              Center(
                child: Text(
                  title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                    fontFamily: 'Montserrat',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
