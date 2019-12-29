import 'dart:math';
import 'package:provider/provider.dart';
import '../custom_widgets/series_item.dart';
import '../providers/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatefulWidget {
  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  var showDetails = false;

  void _showDetails() {
    setState(() {
      showDetails ? showDetails = false : showDetails = true;
    });
  }

  // void _deleteSerie(String serieID) {
  //   setState(() {

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final exercise = Provider.of<Exercise>(context);

    return Column(
      children: <Widget>[
        Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: exercise.listSeries != null
                  ? Text(exercise.listSeries.length.toString())
                  : Text('0'),
            ),
            title: Text(
              exercise.name,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              'Peso Total: ${exercise.totalWeight()}',
            ),
            trailing: IconButton(
              icon: _updateIcon(),
              onPressed: _showDetails,
            ),
          ),
        ),
        showDetails
            ? exercise.listSeries != null && exercise.listSeries.length != 0
                ? Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 5,
                    ),
                    height: min(exercise.listSeries.length.toDouble() * 20.0 + 100, 180),
                    color: Colors.white10,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                        value: exercise,
                        child: SeriesItem(
                          index: index,
                        ),
                      ),
                      addAutomaticKeepAlives: false,
                      itemCount: exercise.listSeries.length,
                    ),
                  )
                : Center(
                    child: Text(
                      'El ejercicio no tiene repeticiones',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
            : Center(),
      ],
    );
  }

  Widget _updateIcon() {
    if (showDetails) {
      return Icon(
        Icons.keyboard_arrow_up,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.keyboard_arrow_down,
        color: Colors.green,
      );
    }
  }
}
