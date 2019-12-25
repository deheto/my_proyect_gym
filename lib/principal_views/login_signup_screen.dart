
import '../custom_widgets/button_switch_account.dart';
import '../custom_widgets/input_email_create.dart';
import '../custom_widgets/input_password_create.dart';
import 'package:flutter/material.dart';


class LoginSignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  static const routeName = '/auth-page';
  
  bool _isLoginForm = false;
  bool _isLogin = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyLittleProgress",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _showCircularProgress(),
                  InputEmail(_emailController),
                  SizedBox(
                    height: 10.0,
                  ),
                  InputPassword(_passwordController),
                  Container(
                    width: 300,
                    // child: CreateAccount(_submit, _isLoginForm),
                  ),
                  SwitchButton(_toggleFormMode, _isLoginForm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLogin) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container();
  }

  void _toggleFormMode() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocurrio un error.'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Entendido.'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }



}
