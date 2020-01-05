


import '../providers/routines_provider.dart';
import 'package:provider/provider.dart';
import '../models/htpp_exception.dart';
import '../custom_widgets/routines_listview.dart';

import 'package:flutter/material.dart';


class RoutinesPage extends StatelessWidget {
  static const routeName = '/routine-page';

  final _nameRoutineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<RoutinesProvider>(context, listen: false)
              .getRoutinesFromDB(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error
                  .toString()
                  .contains('No hay rutinas creadas.')) {
                return Center(
                  child: Text(
                    'No tienes rutinas agregadas.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }

              if (dataSnapshot.error != null) {
                return Center(child: Text('Ocurrio un error.'));

                /***
                 * !!! AÑADIR MA
                 * 
                 */
              } else {
                return RoutinesListView();
              }
            }
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createRoutine(context),
          elevation: 5,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Future<void> _saveRoutine(BuildContext context) async {
  //   try {
  //     await Provider.of<RoutinesProvider>(context).addRoutine(
  //       _nameRoutineController.text,
  //       DateTime.now(),
  //     );
  //   } catch (error) {
  //     await showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: Text('Ocurrió un error.'),
  //         content: Text(error.toString()),
  //         actions: <Widget>[
  //           FlatButton(
  //               child: Text('Okay'),
  //               onPressed: () {
  //                 Navigator.of(ctx).pop();
  //               })
  //         ],
  //       ),
  //     );
  //   }

  // }

  Future<void> _createRoutine(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nombre de la rutina'),
            content: TextField(
              controller: _nameRoutineController,
              decoration: InputDecoration(hintText: "Ejemplo: Hombros/Pierna"),
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
                  // _saveRoutine(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

