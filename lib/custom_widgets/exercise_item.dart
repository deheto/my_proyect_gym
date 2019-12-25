import '../custom_widgets/series_item.dart';
import '../models/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatefulWidget {
  final Exercise exercise;

  ExerciseItem(this.exercise);

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
    return Column(
      children: <Widget>[
        Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            child: ListTile(
              title: Text(
                widget.exercise.name,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                'Peso Total Levantado: 500kg',
              ),
              trailing: IconButton(
                icon: Icon(
                  showDetails
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onPressed: _showDetails,
              ),
            ),
          ),
       
        showDetails
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
                      unitWeight: widget.exercise.listSeries[index].unitWeight,
                    );
                  },
                  addAutomaticKeepAlives: false,
                  itemCount: widget.exercise.listSeries.length,
                ),
              )
            : Center(),
      ],
    );
  }
}
