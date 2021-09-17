import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  // final String? password;
  final TextEditingController? textController;

  const PasswordField({
    Key? key,
    // this.password,
    this.textController,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      key: widget.key,
      obscureText: _hidePassword,
      controller: widget.textController,
      validator: (value) => value!.length < 6 ? 'Password too short' : null,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
        labelStyle:
            const TextStyle(color: Colors.green, fontFamily: 'Montserrat'),
        prefixIcon: const Icon(Icons.lock, color: Colors.green),
        suffixIcon: IconButton(
          color: Colors.green,
          icon: Icon(
            _hidePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
        ),
        hintStyle: const TextStyle(color: Colors.white),
        labelText: 'PASSWORD',
        hintText: 'Enter Your Password',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
