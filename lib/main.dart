import 'package:provider/provider.dart';

import './principal_views/principal_screen.dart';
import './principal_views/routine_details_screen.dart';
import './principal_views/routines_screen.dart';
import './principal_views/login_signup_screen.dart';
import './providers/routines_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: RoutinesProvider(),
        )
      ],
      child: MaterialApp(
        title: 'MyLittleProgress',
        home: PrincipalPage(),
        routes: {
          PrincipalPage.routeName: (ctx) => PrincipalPage(),
          RoutinesPage.routeName: (ctx) => RoutinesPage(),
          RoutineDetailsPage.routeName: (ctx) => RoutineDetailsPage(),
        },
      ),
    );
  }
}
