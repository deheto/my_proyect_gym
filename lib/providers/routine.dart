import 'package:denis_proyect/models/series.dart';

import '../providers/exercise.dart';
import 'package:flutter/foundation.dart';

class Routine with ChangeNotifier{
  final String id;
  final DateTime date;
  final String name;
  List<Exercise> exercises = [];

  Routine({
    @required this.id,
    @required this.date,
    @required this.name,
  });

  Routine.fromDB({
    @required this.exercises,
    @required this.id,
    @required this.date,
    @required this.name,
  });

  void addExerciseToRoutine(String nameExercise) {

      exercises.add(Exercise(name: nameExercise, routineID: id, id: null));
      notifyListeners();
  }

}
