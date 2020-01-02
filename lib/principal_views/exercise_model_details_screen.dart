import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseModelDetailsScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/exercise-model-screen';

  @override
  Widget build(BuildContext context) {
   
    final exerciseID =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final exercise = Provider.of<ExerciseModelProvider>(
      context,
      listen: false,
    ).findExerciseByID(exerciseID);
     final bodyParts = exercise.getBodyPartsString;
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
              height: 200,
              width: double.infinity,
              child: Hero(  
                tag: exercise.id,
                child: Image.network(
                  exercise.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
       
                  height:  MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: RichText(
                        textAlign: TextAlign.center,
                        
                        text: TextSpan(
                          text: 'Descripcion.',
                          style: Theme.of(context).textTheme.title,
                          children: <TextSpan>[

                            TextSpan(
                              text: '\n${exercise.description}\n',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            TextSpan(
                              text:
                                  '\nPartes del cuerpo involucradas.',
                              style: Theme.of(context).textTheme.title,
                            ),
                             TextSpan(
                              text: '\n$bodyParts\n',
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
