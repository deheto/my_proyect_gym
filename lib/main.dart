import './principal_views/exercise_model_details_screen.dart';
import './providers/exercise_model.dart';
import './principal_views/create_routine_screen.dart';
import 'package:provider/provider.dart';
import './principal_views/principal_screen.dart';
import './principal_views/routine_details_screen.dart';
import './principal_views/routines_screen.dart';
// import './principal_views/login_signup_screen.dart';
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
        ),
        ChangeNotifierProvider.value(
          value: (ExerciseModelProvider()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyLittleProgress',
        theme: ThemeData(
          primaryColor: Colors.grey[800],
          accentColor: Colors.lightBlue,
         dividerColor: Colors.grey[800],
         
          scaffoldBackgroundColor: Colors.grey[900],
          // * TEXT STLYE
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Colors.white,
                ),
              
                // * FOR TEXT INPUT STRINGS
                display1: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.white,
                ),
                body1: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              
          // * APPBAR STYLE
          appBarTheme: AppBarTheme(
            color: Colors.grey[800],
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
          ),
        ),
        home: CreateRoutineScreen(),
        routes: {
          PrincipalPage.routeName: (ctx) => PrincipalPage(),
          RoutinesPage.routeName: (ctx) => RoutinesPage(),
          RoutineDetailsPage.routeName: (ctx) => RoutineDetailsPage(),
           ExerciseModelDetailsScreen.routeName: (ctx) => ExerciseModelDetailsScreen(),
        },
      ),
    );
  }
}
