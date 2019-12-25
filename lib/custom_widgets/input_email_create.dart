import 'package:flutter/material.dart';

class InputEmail extends StatelessWidget {
  final TextEditingController emailController;

  InputEmail(this.emailController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          )),
      validator: (input) {
        if (input.isEmpty) {
          return 'El correo no puede estar vacío';
        } else if (!input.contains('@')) {
          return 'El correo es inválido';
        }
        return null;
      },
      controller: emailController,
    );
  }
}
