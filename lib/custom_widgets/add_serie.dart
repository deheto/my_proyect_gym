import '../providers/exercise.dart';

import '../models/unity_weight.dart';
import 'package:flutter/material.dart';

class AddSerie extends StatefulWidget {
  
  final Exercise exercise;

  AddSerie(this.exercise);

  @override
  _AddSerieState createState() => _AddSerieState();
}

class _AddSerieState extends State<AddSerie> {
  var lbsChoiced = true;
  final _repTotalesController = TextEditingController();
  final _weightController = TextEditingController();
  UnityWeight unityWeight = UnityWeight.lbs;

  void _submitData() {
    final weight = double.parse(_weightController.text);
    final reps = int.parse( _repTotalesController.text);

    if (weight == null || reps == null) {
      return;
    }

    widget.exercise.addSerieToExercise(widget.exercise.id, weight, reps, unityWeight);
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso'),
              controller: _weightController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  color: Colors.black,
                  disabledColor: Colors.green,
                  child: Text(
                    'lbs',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: lbsChoiced ? null : _selectLbs,
                  highlightColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                RaisedButton(
                  color: Colors.black,
                  disabledColor: Colors.green,
                  child: Text(
                    'kgs',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: lbsChoiced ? _selectKgs : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ],
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Cantidad de repeticiones'),
              controller: _repTotalesController,
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: RaisedButton(
                child: Text('Agregar serie'),
                onPressed: () => _submitData(),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectLbs() {
    setState(() {
      unityWeight = UnityWeight.lbs;
      lbsChoiced = true;
      print('LBS CHOOSED');
    });
  }

  void _selectKgs() {
    setState(() {
      unityWeight = UnityWeight.kgs;
      lbsChoiced = false;
      print('KGS CHOOSED');
    });
  }
}
