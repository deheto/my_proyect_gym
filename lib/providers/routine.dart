import 'dart:convert';
import '../models/htpp_exception.dart';
import '../models/series.dart';
import 'package:http/http.dart' as http;
import '../providers/exercise.dart';
import 'package:flutter/foundation.dart';

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

  List<Exercise> get getListExercises {
    return [..._exercises];
  }

  int getExerciseListLenght() {
    return _exercises.length;
  }

  Future<void> addExerciseToRoutine(String nameExercise) async {
    final url = 'https://gym-proyect.firebaseio.com/routines/$id.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'exercises': {
            'routineID': id,
            'name': nameExercise,
          }
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

  // Future<void> removeExercise(String idExercise) async {
  //   final url = 'https://gym-proyect.firebaseio.com/routines/$id';

  //   final existingExerciseIndex =
  //       _exercises.indexWhere((exercise) => exercise.id == idExercise);

  //   var existingExercise = _exercises[existingExerciseIndex];
  //   _exercises.removeAt(existingExerciseIndex);
  //   notifyListeners();
  //   final response = await http.delete(url);

  //   if (response.statusCode >= 400) {
  //     _exercises.insert(existingExerciseIndex, existingExercise);
  //     notifyListeners();
  //     throw HttpException('No se pudo eliminar el ejercicio.');
  //   }

  //   existingExercise = null;
  // }
}
