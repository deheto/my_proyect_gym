

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInManager{

  static GoogleSingInManager _instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
   scopes: [
      'email',
   ],

);

  static GoogleSingInManager getInstance(){

     if (_instance == null) {
      _instance = GoogleSingInManager();
    }

    return _instance;
  }


     loginGoogle() async {

    try {

     await _googleSignIn.signIn();

      print(_googleSignIn.currentUser.email);

    } catch(error){

    }

  } 

  logoutGoogle() async {

    try {

      _googleSignIn.signOut();

    } catch(error){

    }

  } 

}