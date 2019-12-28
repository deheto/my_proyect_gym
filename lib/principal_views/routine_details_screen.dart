import 'package:denis_proyect/providers/exercise.dart';

import '../providers/routine.dart';
import '../providers/routines_provider.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../custom_widgets/add_serie.dart';
import '../custom_widgets/exercise_item.dart';

class RoutineDetailsPage extends StatefulWidget {
  static const routeName = '/routine-details-page';

  @override
  _RoutineDetailsPageState createState() => _RoutineDetailsPageState();
}

class _RoutineDetailsPageState extends State<RoutineDetailsPage> {
  TextEditingController _nameExerciseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routineID = ModalRoute.of(context).settings.arguments as String;
    final routine = Provider.of<RoutinesProvider>(context, listen: false)
        .findRoutineByID(routineID);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('${routine.name}, ${DateFormat.yMMMd().format(routine.date)}'),
      ),
      // drawer: MainDrawer(),
      /*
      * ! ARREGLAR EL TAMAÑO QUE TOMA LA LISTA      
      */
      body: Container(
        height: 525,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: routine.exercises[index],
            child: Slidable(
              key: Key(routine.exercises[index].name),
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Eliminar',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => _confirmDeleteExercise(index, routine),
                ),
                IconSlideAction(
                  caption: 'Agregar serie',
                  color: Colors.green,
                  icon: Icons.add,
                  onTap: () => _addSerie(routine.exercises[index]),
                ),
              ],
              closeOnScroll: false,
              child: routine.exercises.length <= 0 
                  ? Center()
                  : ExerciseItem(),
            ),
          ),
          addAutomaticKeepAlives: false,
          itemCount: routine.exercises.length,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _addExercise(routine),
          elevation: 5,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addSerie(Exercise exercise) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddSerie(exercise),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future<void> _confirmDeleteExercise(int index, Routine routine) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(routine.exercises[index].name),
          content: Text('¿Desea realmente eliminarlo?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
                child: Text('Eliminar'),
                onPressed: () {
                  setState(() {
                    routine.exercises.removeAt(index);
                  });
                  Navigator.pop(context);
                  // Scaffold.of(context).showSnackBar(SnackBar(
                  //     content: Text("${listExercise[index].name} eliminado.")));
                }),
          ],
        );
      },
    );
  }

  Future<void> _addExercise(Routine routine) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nombre del ejercicio'),
            content: TextField(
              controller: _nameExerciseController,
              decoration:
                  InputDecoration(hintText: "Ejemplo: Sentadilla Bulgara"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Agregar'),
                onPressed: () {
                  _createExercise(routine);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _createExercise(Routine routine) {
    setState(() {
      routine.addExerciseToRoutine(_nameExerciseController.text);
    });
  }
}
