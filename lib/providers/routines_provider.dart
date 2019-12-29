import 'package:denis_proyect/models/htpp_exception.dart';

import '../providers/routine.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RoutinesProvider with ChangeNotifier {
  List<Routine> _routines = [
      // Routine.fromDB(
      //   Routine.getList: [
      //     Exercise.fromDB(
      //       routineID: 'r2',
      //       id: 'd3a',
      //       name: 'Sentadilla',
      //       listSeries: [
      //         Series(
      //           exerciseID: 'd3a',
      //           id: '23',
      //           weigth: 15,
      //           repTotal: 3,
      //           unityWeight: UnityWeight.lbs,
      //         ),
      //         Series(
      //           exerciseID: 'd3a',
      //           id: '3',
      //           weigth: 31,
      //           repTotal: 32,
      //           unityWeight: UnityWeight.lbs,
      //         ),
      //         Series(
      //           exerciseID: 'd3a',
      //           id: '1',
      //           weigth: 32,
      //           repTotal: 1,
      //           unityWeight: UnityWeight.lbs,
      //         ),
      //       ],
      //     ),
      //   ],
      //   name: 'Pierna',
      //   date: DateTime.now(),
      //   id: 'd2',
      // ),
 
  ];

  List<Routine> get routines {
    return [..._routines];
  }

  Routine findRoutineByID(String id) {
    return _routines.firstWhere((rout) => rout.id == id);
  }

  Future<void> getRoutinesFromFireBase() async {
    const url = 'https://gym-proyect.firebaseio.com/routines.json';

 
      final response = await http.get(url);

      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Routine> tempList = [];

      if (data == null){
         throw HttpException('No hay rutinas creadas.');
      }

      data.forEach((routineID, routineData) {
        tempList.add(Routine(
          id: routineID,
          date: DateTime.parse(routineData['date']),
          name: routineData['name'],
        ));
      });

      _routines = tempList;
      notifyListeners();
  
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
}
