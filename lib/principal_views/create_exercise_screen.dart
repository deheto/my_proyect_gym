import 'package:flutter/material.dart';

class CreateExercise extends StatelessWidget {

  static const routeName = '/create-exercise';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Diseña tu ejercicio'),
        textTheme: Theme.of(context).appBarTheme.textTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

                

          ],
        ),
      ),

    );
  }
}