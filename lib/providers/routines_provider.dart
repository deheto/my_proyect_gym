import '../providers/routine.dart';
import '../models/unity_weight.dart';
import '../providers/exercise.dart';
import '../models/series.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RoutinesProvider with ChangeNotifier {
  List<Routine> _routines = [
    Routine.fromDB(
      exercises: [
        Exercise.fromDB(
          routineID: 'r2',
          id: 'd3a',
          name: 'Sentadilla',
          listSeries: [
            Series(
              exerciseID: 'd3a',
              id: '23',
              weigth: 15,
              repTotal: 3,
              unityWeight: UnityWeight.lbs,
            ),
            Series(
              exerciseID: 'd3a',
              id: '3',
              weigth: 31,
              repTotal: 32,
              unityWeight: UnityWeight.lbs,
            ),
            Series(
              exerciseID: 'd3a',
              id: '1',
              weigth: 32,
              repTotal: 1,
              unityWeight: UnityWeight.lbs,
            ),
          ],
        ),
      ],
      name: 'Pierna',
      date: DateTime.now(),
      id: 'd2',
    ),
    Routine.fromDB(
      exercises: [
        Exercise.fromDB(
          routineID: 'r1',
          id: 'pb3',
          name: 'Press Banca',
          listSeries: [
            Series(
              exerciseID: 'pb3',
              id: '5',
              weigth: 32,
              repTotal: 64,
              unityWeight: UnityWeight.kgs,
            ),
            Series(
              exerciseID: 'pb3',
              id: '6',
              weigth: 315,
              repTotal: 32,
              unityWeight: UnityWeight.kgs,
            ),
            Series(
              exerciseID: 'pb3',
              id: '7',
              weigth: 2,
              repTotal: 31,
              unityWeight: UnityWeight.kgs,
            ),
          ],
        ),
      ],
      name: 'Torso',
      date: DateTime.now(),
      id: 'p1',
    ),
  ];

  List<Routine> get routines {
    return [..._routines];
  }

  Routine findRoutineByID(String id) {
    return _routines.firstWhere((rout) => rout.id == id);
  }

  Future<void> addRoutine(String name, DateTime date) async {
    const url = 'https://gym-proyect.firebaseio.com/routines';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': name,
            'date': date.toString(),
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
}
