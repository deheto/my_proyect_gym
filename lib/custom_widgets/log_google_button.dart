import '../apis/google_sing_in.dart';
import 'package:flutter/material.dart';

class LoginGoogleButton extends StatelessWidget {

 

    final GoogleSingInManager _googleManager =  GoogleSingInManager.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFFF8F00),
            Color(0xFFFF6F00),
            Color(0xFFFFB300),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: 215,
      height: 40,
      child: Row(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 50,
              width: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/google_logo.png',
                ),
              ),
            ),
         
          FlatButton(
            onPressed: () => _googleManager.loginGoogle(),
            child: Text(
              'Logea con Google',
              style: Theme.of(context).textTheme.display3,
            ),
          ),
        ],
      ),
    );
  }
}
