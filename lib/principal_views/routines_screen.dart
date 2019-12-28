import '../providers/routines_provider.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/routines_listview.dart';

import 'package:flutter/material.dart';

class RoutinesPage extends StatefulWidget {
  static const routeName = '/routine-page';

  @override
  _RoutinesPageState createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  var _isLoading = false;

  final _nameRoutineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RoutinesListView(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createRoutine(),
          elevation: 5,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _saveRoutine() async {
    try {
      await Provider.of<RoutinesProvider>(context).addRoutine(
        _nameRoutineController.text,
        DateTime.now(),
      );
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocurrió un erorr.'),
          content: Text(error.toString()),
          actions: <Widget>[
            FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                })
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createRoutine()  {
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
                  setState(() {
                    _isLoading = true;
                  });
                       
                  _saveRoutine();
           Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
