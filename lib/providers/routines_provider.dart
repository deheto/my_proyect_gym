import 'package:provider/provider.dart';

import '../models/htpp_exception.dart';
import '../models/series.dart';
import '../models/unity_weight.dart';
import '../providers/exercise_user.dart';

import '../providers/routine.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RoutinesProvider with ChangeNotifier {
  List<Routine> _routines = [];

  List<Routine> get copyRoutines {
    return [..._routines];
  }

  List<Routine> get routines {
    return _routines;
  }

  Routine findRoutineByID(String id) {
    return _routines.firstWhere((rout) => rout.id == id);
  }

  Future<void> getRoutinesFromFireBase() async {
    const url = 'https://gym-proyect.firebaseio.com/routines.json';

    print('LLAMA AL METODO 2 VECES');

    final response = await http.get(url);

    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<Routine> tempList = [];

    if (data == null) {
      throw HttpException('No hay rutinas creadas.');
    }

    // print(json.decode(response.body));

    data.forEach((routineID, routineData) {
      tempList.add(Routine(
        id: routineID,
        date: DateTime.parse(routineData['date']),
        name: routineData['name'],
      ));
    });

    await _fillRoutinesExercises(tempList);

    _routines = tempList;
    notifyListeners();
  }

  Future<void> _fillRoutinesExercises(List<Routine> tempList) async {
    const url = 'https://gym-proyect.firebaseio.com/exercises.json';

    final response = await http.get(url);

    final data = json.decode(response.body) as Map<String, dynamic>;

    if (data == null) {
      return;
    }

    // print(json.decode(response.body));

    List<ExerciseUser> exercisesToFill = [];
    Routine routine;
    ExerciseUser exercise;

    data.forEach((exerciseID, exerciseData) {
      routine =
          tempList.firstWhere((rout) => rout.id == exerciseData['routineID']);

      if (routine != null) {
        exercise = ExerciseUser(
          id: exerciseID,
          name: exerciseData['name'],
          routineID: exerciseData['routineID'],
        );

        routine.fillExercises(exercise);
        exercisesToFill.add(exercise);
      }
    });

    await _fillExercises(exercisesToFill);
  }

  Future<void> _fillExercises(List<ExerciseUser> exercisesToFill) async {
    const url = 'https://gym-proyect.firebaseio.com/series.json';

    final response = await http.get(url);

    final data = json.decode(response.body) as Map<String, dynamic>;

    if (data == null) {
      return;
    }

    ExerciseUser exercise;
    UnityWeight unityWeight;

    data.forEach((serieID, serieData) {
      exercise = exercisesToFill
          .firstWhere((exercise) => exercise.id == serieData['exerciseID']);

      if (exercise != null) {
        'lbs'.contains(serieData['unityWeight'])
            ? unityWeight = UnityWeight.lbs
            : unityWeight = UnityWeight.kgs;

        exercise.addSerie(
          Series(
              exerciseID: serieData['exerciseID'],
              id: serieID,
              weigth: double.parse(serieData['weigth']),
              repTotal: int.parse(serieData['repTotal']),
              unityWeight: unityWeight),
        );
      }
    });
  }

  Future<void> addRoutine(String name, DateTime date) async {
    const url = 'https://gym-proyect.firebaseio.com/routines.json';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': name,
            'date': date.toIso8601String(),
          },
        ),
      );

      _routines.add(Routine(
        date: date,
        id: json.decode(response.body)['name'],
        name: name,
      ));

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  int _getRoutineID(String routineID) {
    return _routines.indexWhere((rout) => rout.id == routineID);
  }

  Future<void> deleteRoutine(String routineID) async {
    final url = 'https://gym-proyect.firebaseio.com/routines/$routineID.json';

    final existingRoutineIndex = _getRoutineID(routineID);
    var existingRoutine = _routines[existingRoutineIndex];

    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _routines.insert(existingRoutineIndex, existingRoutine);
      notifyListeners();
      throw HttpException('No se pudo eliminar la rutina.');
    }

    String urlDeleteExercise;
    String urlDeleteSerie;

    existingRoutine.getCopyListExercises.forEach((exercise) async {
      urlDeleteExercise =
          'https://gym-proyect.firebaseio.com/exercises/${exercise.id}.json';

      final response = await http.delete(urlDeleteExercise);

      if (response.statusCode >= 400) {
        throw HttpException('No se pudo eliminar el ejercicio.');
      }

      exercise.listSeries.forEach((serie) async {
        urlDeleteSerie =
            'https://gym-proyect.firebaseio.com/series/${serie.id}.json';

        final response = await http.delete(urlDeleteSerie);

        if (response.statusCode >= 400) {
          throw HttpException('No se pudo eliminar el ejercicio.');
        }
      });
    });

    existingRoutine = null;
  }
}
