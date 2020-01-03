import 'package:uuid/uuid.dart';

import '../providers/routine.dart';

import '../principal_views/exercise_model_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseModelItem extends StatefulWidget {
  @override
  _ExerciseModelItemState createState() => _ExerciseModelItemState();

  final Routine _routine;

  ExerciseModelItem(this._routine);
}

class _ExerciseModelItemState extends State<ExerciseModelItem> {
  final uuid = Uuid();

  String exerciseID;

  @override
  void initState() {
    exerciseID = uuid.v4();
    super.initState();
  }

  double opacityLevel = 0.1;
  @override
  Widget build(BuildContext context) {
    final exerciseModel = Provider.of<ExerciseModel>(context, listen: false);
    return ClipRRect(
      child: GridTile(
        child: AnimatedOpacity(
          opacity: opacityLevel,
          duration: Duration(seconds: 1),
          child: Hero(
            tag: exerciseModel.id,
            child: Image.network(
              exerciseModel.imageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: Container(
          height: 40,
          child: GestureDetector(
            onTap: () {
              setState(() {
                opacityLevel = exerciseModel.isChosen ?   0.1 : 1.0;
                exerciseModel.changeChosenStatus();
              });
              _manageRoutineExercise(exerciseModel, widget._routine);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: exerciseModel.isChosen
                      ? Text(
                          'Ejercicio añadido a la rutina.',
                        )
                      : Text(
                          'Ejercicio eliminado de la rutina.',
                        ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: GridTileBar(
              leading: Consumer<ExerciseModel>(
                builder: (ctx, exercise, _) => IconButton(
                  icon: Icon(
                    exercise.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    exercise.changeFavoriteStatus();

                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: exercise.isFavorite
                            ? Text(
                                'Ejercicio añadido a favoritos.',
                              )
                            : Text(
                                'Ejercicio eliminado de favoritos.',
                              ),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                exerciseModel.name,
                textAlign: TextAlign.center,
              ),
              //* SHOW INFO
              trailing: IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ExerciseModelDetailsScreen.routeName,
                    arguments: exerciseModel.id,
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _manageRoutineExercise(ExerciseModel exerciseModel, Routine routine) {
    exerciseModel.isChosen
        ? routine.addExerciseToRoutine(exerciseModel, exerciseID)
        : routine.deleteExercise(exerciseID);
  }


}
