import 'dart:convert';

import '../models/htpp_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../providers/exercise_user.dart';

class Routine with ChangeNotifier {
  final String id;
  final DateTime date;
  final String name;
  final List<ExerciseUser> _exercises = [];

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

  List<ExerciseUser> get getCopyListExercises {
    return [..._exercises];
  }

   List<ExerciseUser> get getListExercises {
    return _exercises;
  }

  int getExerciseListLenght() {
    return _exercises.length;
  }

  void fillExercises(ExerciseUser exercise) {
    _exercises.add(exercise);
  }

   int _getExerciseIndex(String exerciseID){
    return _exercises.indexWhere((ex) => ex.id == exerciseID);

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

      _exercises.add(ExerciseUser(
        name: nameExercise,
        id: json.decode(response.body)['name'],
        routineID: id,
      ));

      notifyListeners();
    } catch (error) {}
  }
 Future<void> removeExercise(String idExercise) async {
    final url = 'https://gym-proyect.firebaseio.com/exercises/$idExercise.json';

    final existingExerciseIndex = _getExerciseIndex(idExercise);
    var existingExercise = _exercises[existingExerciseIndex];


    notifyListeners();
    
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _exercises.insert(existingExerciseIndex, existingExercise);
      notifyListeners();
      throw HttpException('No se pudo eliminar el ejercicio.');
    }

    String urlSerie;

    existingExercise.listSeries.forEach((serie) async{

   urlSerie = 'https://gym-proyect.firebaseio.com/series/${serie.id}.json';
 
      final response = await http.delete(urlSerie);

    if (response.statusCode >= 400) {
      throw HttpException('No se pudo eliminar las series del ejercicio.');
    }

    });
  

    existingExercise = null;
  }
  

  
}
