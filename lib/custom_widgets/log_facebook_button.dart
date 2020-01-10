import 'package:flutter/material.dart';

class LoginFacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF3F51B5),
            Color(0xFF1A237E),
            Color(0xFF283593),
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
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'images/facebook_logo.png',
                ),
              ),
            ),
         
          FlatButton(
            onPressed: () => null,
            child: Text(
              'Logea con Facebook',
              style: Theme.of(context).textTheme.display3,
            ),
          ),
        ],
      ),
    );
  }
}
