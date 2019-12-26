import 'package:enum_to_string/enum_to_string.dart';

import '../models/unity_weight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeriesItem extends StatelessWidget {
  final double weigth;
  final int repTotal;
  final String id;
  final UnityWeight unityWeight;

  SeriesItem({
    @required this.id,
    @required this.weigth,
    @required this.repTotal,
    @required this.unityWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        title: Text('Peso: ${weigth.toInt()} ${EnumToString.parse(unityWeight)}'),
        subtitle: Text('Repeticiones totales:  $repTotal'),
        trailing: IconButton(
          icon: Icon(Icons.delete,
          color: Colors.red,),
          onPressed: null,
        ),
      ),
    );
  }
}