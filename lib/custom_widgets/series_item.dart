import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeriesItem extends StatelessWidget {
  final double weigth;
  final int repTotal;
  final String id;
  final String unitWeight;

  SeriesItem({
    @required this.id,
    @required this.weigth,
    @required this.repTotal,
    @required this.unitWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        title: Text('Peso: ${weigth.toInt()} $unitWeight'),
        subtitle: Text('Repeticiones totales:  $repTotal'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: null,
        ),
      ),
    );
  }
}
