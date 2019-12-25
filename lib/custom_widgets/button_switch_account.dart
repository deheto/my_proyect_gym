import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {

  final Function toggleFormMode;
  final isLoginForm;

  SwitchButton(this.toggleFormMode, this.isLoginForm);

  @override
  Widget build(BuildContext context) {
    return FlatButton(

            child: Text(
                isLoginForm
                    ? 'Cree una nueva cuenta'
                    : '¿Ya tiene cuenta? Ingrese',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
            onPressed: toggleFormMode,

    );
  }
}
