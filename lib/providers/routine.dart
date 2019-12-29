import 'dart:convert';

import '../models/htpp_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../providers/exercise.dart';

class Routine with ChangeNotifier {
  final String id;
  final DateTime date;
  final String name;
  final List<Exercise> _exercises = [];

  Routine({
    @required this.id,
    @required this.date,
    @required this.name,
  });

  Routine.fromDB({
    @required this.id,
    @required this.date,
    @required this.name,
  });

  List<Exercise> get getCopyListExercises {
    return [..._exercises];
  }

   List<Exercise> get getListExercises {
    return _exercises;
  }

  int getExerciseListLenght() {
    return _exercises.length;
  }

  void fillExercises(Exercise exercise) {
    _exercises.add(exercise);
  }

  Future<void> addExerciseToRoutine(String nameExercise) async {
    const url = 'https://gym-proyect.firebaseio.com/exercises.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'routineID': id,
          'name': nameExercise,
        }),
      );

      print(json.decode(response.body));

      _exercises.add(Exercise(
        name: nameExercise,
        id: json.decode(response.body)['name'],
        routineID: id,
      ));

      notifyListeners();
    } catch (error) {}
  }

  Future<void> removeExercise(int index, String idExercise) async {
    final url = 'https://gym-proyect.firebaseio.com/exercises/$idExercise.json';

    // final existingExerciseIndex =
    //     _exercises.indexWhere((exercise) => exercise.id == idExercise);

    var existingExercise = _exercises[index];
    _exercises.removeAt(index);

    notifyListeners();
    
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _exercises.insert(index, existingExercise);
      notifyListeners();
      throw HttpException('No se pudo eliminar el ejercicio.');
    }

    String urlSerie;

    existingExercise.listSeries.forEach((serie) async{

   urlSerie = 'https://gym-proyect.firebaseio.com/series/${serie.id}.json';
 
      final response = await http.delete(urlSerie);

    if (response.statusCode >= 400) {
      throw HttpException('No se pudo eliminar el ejercicio.');
    }

    });
  

    existingExercise = null;
  }
}
