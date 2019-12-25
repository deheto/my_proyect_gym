import 'package:denis_proyect/models/series.dart';

import '../custom_widgets/exercise_item.dart';
import '../models/exercise.dart';
import 'package:flutter/material.dart';

class RoutineDetailsPage extends StatefulWidget {
  // final List<Exercise> listExercise;

  static const routeName = '/routine-details-page';

  // RoutineDetailsPage(this.listExercise);

  @override
  _RoutineDetailsPageState createState() => _RoutineDetailsPageState();
}

class _RoutineDetailsPageState extends State<RoutineDetailsPage> {
  final List<Exercise> listExercise = [
    Exercise(
      id: 'd3a',
      name: 'Sentadilla',
      listSeries: [
        Series(
          id: '23',
          weigth: 15,
          repTotal: 3,
          unitWeight: 'lbs',
        ),
        Series(
          id: '3',
          weigth: 31,
          repTotal: 32,
          unitWeight: 'lbs',
        ),
        Series(
          id: '1',
          weigth: 32,
          repTotal: 1,
          unitWeight: 'kg',
        ),
      ],
    ),
    Exercise(
      id: 'pb3',
      name: 'Press Banca',
      listSeries: [
        Series(
          id: '5',
          weigth: 32,
          repTotal: 64,
          unitWeight: 'lb',
        ),
        Series(
          id: '6',
          weigth: 315,
          repTotal: 32,
          unitWeight: 'kg',
        ),
        Series(
          id: '7',
          weigth: 2,
          repTotal: 31,
          unitWeight: 'kg',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOMBRE DE LA RUTINA'),
      ),

      /*
      * ! ARREGLAR EL TAMAÑO QUE TOMA LA LISTA      
      */
      body: Container(
        height: 500,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (ctx, index) {
            return Dismissible(
              key: ValueKey(listExercise[index].id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Theme.of(context).errorColor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                alignment: Alignment.centerRight,
              ),
              onDismissed: (_) {
                setState(() {
                  listExercise.removeAt(index);
                });
              },
              child: ExerciseItem(listExercise[index]),
            );
          },
          addAutomaticKeepAlives: false,
          itemCount: listExercise.length,
        ),
      ),
    );
  }
}
