import '../custom_widgets/series_item.dart';
import '../models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatefulWidget {
  final Exercise exercise;
  final int numberExercise;

  ExerciseItem(this.exercise,this.numberExercise);

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

  @override
  Widget build(BuildContext context) {
    var number = 1 + widget.numberExercise;
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
            child: Text(number.toString()),

           ), 
            title: Text(
              widget.exercise.name,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              'Peso Total Levantado: 500kg',
            ),
            trailing: IconButton(
              icon: _updateIcon(),
              onPressed: _showDetails,
            ),
          ),
        ),
        showDetails
            ? widget.exercise.listSeries != null
                ? Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 5,
                    ),
                    height: 65 * widget.exercise.listSeries.length.toDouble(),
                    color: Colors.white10,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemBuilder: (ctx, index) {
                        return SeriesItem(
                          repTotal: widget.exercise.listSeries[index].repTotal,
                          id: widget.exercise.listSeries[index].id,
                          weigth: widget.exercise.listSeries[index].weigth,
                          unityWeight:
                              widget.exercise.listSeries[index].unityWeight,
                        );
                      },
                      addAutomaticKeepAlives: false,
                      itemCount: widget.exercise.listSeries.length,
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
