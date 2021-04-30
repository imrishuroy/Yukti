import 'package:flutter/material.dart';

class ReuseableEmailField extends StatelessWidget {
  final TextEditingController? textController;

  ReuseableEmailField({
    Key? key,
    this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      key: key,
      // onSaved: (value) => email = value,
      keyboardType: TextInputType.emailAddress,
      controller: textController,
      validator: (value) =>
          !(value!.contains('@gmail.com')) ? 'Invalid Email' : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.green,
        ),
        labelText: 'EMAIL',
        labelStyle: TextStyle(
          color: Colors.green,
          fontFamily: 'Montserrat',
        ),
        hintText: 'Enter Your Email',
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
      ),
    );
  }
}
