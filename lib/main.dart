import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './principal_views/create_exercise_screen.dart';
import './principal_views/exercise_model_details_screen.dart';
import './principal_views/login_signup_screen.dart';
import './principal_views/principal_screen.dart';
import './principal_views/routine_details_screen.dart';
import './principal_views/routines_screen.dart';
import './providers/exercise_model.dart';
import './providers/routines_provider.dart';

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
          value: ExerciseModelProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyLittleProgress',
        theme: ThemeData(
          primaryColor: Colors.grey[800],
          accentColor: Colors.lightBlue,
          cardColor: Colors.grey[700],
          bottomAppBarColor: Colors.purpleAccent[700],
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

                /**
                 * 
                 * * FOR SHOWING PREVIEW ROUTINE 
                 *  */

                display4: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 30,
                  color: Colors.white,
                ),

                //* FOR BUTTONS
                display3: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  color: Colors.white,
                ),

                body1: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Colors.white,
                ),

                /**
                 * *FOR PARAGRAPH
                 */
                body2: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
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
        home: PrincipalPage(),
        routes: {
          PrincipalPage.routeName: (ctx) => PrincipalPage(),
          RoutinesPage.routeName: (ctx) => RoutinesPage(),
          RoutineDetailsPage.routeName: (ctx) => RoutineDetailsPage(),
          ExerciseModelDetailsScreen.routeName: (ctx) =>
              ExerciseModelDetailsScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          CreateExercise.routeName: (ctx) => CreateExercise(),
        },
      ),
    );
  }
}
