import '../providers/exercise.dart';
import 'package:provider/provider.dart';
import '../providers/routine.dart';
import '../providers/routines_provider.dart';
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

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final routine = ModalRoute.of(context).settings.arguments as Routine;
    final copyRoutine = routine.getListExercises;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('${routine.name}, ${DateFormat.yMMMd().format(routine.date)}'),
      ),
      // drawer: MainDrawer(),
      /*
        * ! ARREGLAR EL TAMAÑO QUE TOMA LA LISTA      
        */
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: 525,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                  value: copyRoutine[index],
                  child: Slidable(
                    key: Key(copyRoutine[index].id),
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Eliminar',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => _confirmDeleteExercise(index, copyRoutine),
                      ),
                      IconSlideAction(
                        caption: 'Agregar serie',
                        color: Colors.green,
                        icon: Icons.add,
                        onTap: () => _addSerie(copyRoutine[index]),
                      ),
                    ],
                    closeOnScroll: false,
                    child: copyRoutine.length <= 0 ? Center() : ExerciseItem(),
                  ),
                ),
                addAutomaticKeepAlives: false,
                itemCount: copyRoutine.length,
              )),
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

  Future<void> _confirmDeleteExercise(
      int index, List<Exercise> copyRoutine) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(copyRoutine[index].name),
          content: Text('¿Desea realmente eliminarlo?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
                child: Text('Eliminar'),
                onPressed: () async {
                  try {
                    // await routine.removeExercise(exercises[index].id);
                  } catch (error) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Eliminar fallo.',
                        textAlign: TextAlign.center,
                      ),
                    ));
                  }
                  Navigator.pop(context);
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
                onPressed: () async {
                  try {
                    Navigator.of(context).pop();

                    setState(() {
                      isLoading = true;
                    });

                    await routine
                        .addExerciseToRoutine(_nameExerciseController.text);


                  } catch (error) {
                    /*** 
                         *
                         *    !!!HACER ALGO AQUI 
                         ***/
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ],
          );
        });
  }
}
