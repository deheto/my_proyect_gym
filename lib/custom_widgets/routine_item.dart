import '../providers/routine.dart';
import '../providers/routines_provider.dart';
import 'package:provider/provider.dart';
import '../principal_views/routine_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoutineItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedRoutine = Provider.of<Routine>(context, listen: false);

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
          leading: CircleAvatar(
            child: Consumer<Routine>(
              builder: (ctx, updateRoutine, child) => FittedBox(
                child: Text(
                  updateRoutine.getExerciseListLenght().toString(),
                ),
              ),
            ),
          ),
          title: Text(
            loadedRoutine.name,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMEd().format(loadedRoutine.creationDate),
          ),
          trailing: IconButton(
            icon: Icon(Icons.forward),
            onPressed: () {
             
              Navigator.of(context).pushNamed(
                RoutineDetailsPage.routeName,
                arguments: loadedRoutine,
              );
            },
          ),
          onLongPress: () async {

            try{

             Provider.of<RoutinesProvider>(context, listen: false).deleteRoutine(loadedRoutine.id);
         
         
         
          }catch(error){

            /**
             * 
             * !!! AGREGAR MANEJO DE ERRORES!!
             */

          }

          }),
    );
  }

 
}
