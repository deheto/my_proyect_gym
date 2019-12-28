import '../providers/exercise.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:provider/provider.dart';

import '../models/unity_weight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeriesItem extends StatelessWidget {
  // final Function deleteSerie;
  // final double weigth;
  // final int repTotal;
  // final String id;
  // final UnityWeight unityWeight;
  final int index;
  SeriesItem({
    @required this.index,
    // @required this.weigth,
    // @required this.repTotal,
    // @required this.unityWeight,
    // this.deleteSerie,
  });

  @override
  Widget build(BuildContext context) {

    final exercise = Provider.of<Exercise>(context, listen: false);

    return Card(
      elevation: 1,
      child: ListTile(
        title:
            Text('Peso: ${exercise.listSeries[index].weigth.toInt()} ${EnumToString.parse(exercise.listSeries[index].unityWeight)}'),
        subtitle: Text('Repeticiones totales:  ${exercise.listSeries[index].repTotal}'),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () => exercise.deleteSerie(index),
        ),
      ),
    );
  }
}
