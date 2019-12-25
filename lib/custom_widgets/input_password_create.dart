import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatelessWidget {
  final TextEditingController passwordController;

  InputPassword(this.passwordController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Password',
        icon:  Icon(
          Icons.lock,
          color: Colors.grey,
        ),
      ),
      validator: (input) =>
          input.isEmpty ? 'La contraseña no puede estar vacía' : null,
      controller: passwordController,
    );
  }
}
