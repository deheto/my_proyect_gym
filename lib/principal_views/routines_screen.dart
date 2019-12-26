import '../models/series.dart';
import '../models/unity_weight.dart';

import '../models/exercise.dart';

import '../custom_widgets/routine_item.dart';
import '../models/routine.dart';
import 'package:flutter/material.dart';

class RoutinesPage extends StatelessWidget {
  static const routeName = '/routine-page';

  final List<Routine> routines = [
    Routine(
      exercises: [
        Exercise(
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
      type: 'Pierna',
      date: DateTime.now(),
      id: 'd2',
    ),
    Routine(
      exercises: [
        Exercise(
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
      type: 'Torso',
      date: DateTime.now(),
      id: 'p1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutinas'),
      ),

      /*
      * ! ARREGLAR EL TAMAÑO QUE TOMA LA LISTA      
      */
      body: Container(
        height: 500,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (ctx, index) {
            return RoutineItem(
              routine: routines[index],
            );
          },
          addAutomaticKeepAlives: false,
          itemCount: routines.length,
        ),
      ),
    );
  }
}
