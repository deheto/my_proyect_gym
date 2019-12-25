import '../custom_widgets/routine_item.dart';
import '../models/routine.dart';
import 'package:flutter/material.dart';

class RoutinesPage extends StatelessWidget {
  static const routeName = '/routine-page';

  final List<Routine> routines = [
    Routine(
      type: 'Torso',
      date: DateTime.now(),
      id: 'd2',
    ),
    Routine(
      type: 'Pierna',
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
              type: routines[index].type,
              date: routines[index].date,
            );
          },
          addAutomaticKeepAlives: false,
          itemCount: routines.length,
        ),
      ),
    );
  }
}
