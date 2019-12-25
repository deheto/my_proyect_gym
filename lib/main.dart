import 'principal_views/principal_screen.dart';
import 'principal_views/routines_screen.dart';
import 'package:flutter/material.dart';
import 'principal_views/login_signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyLittleProgress',
      home: PrincipalPage(),
      routes: {
         PrincipalPage.routeName: (ctx) => PrincipalPage(),
               RoutinesPage.routeName: (ctx) => RoutinesPage(),
   
      },
    );
  }
}
