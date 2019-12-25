import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoutineItem extends StatelessWidget {
  final String type;
  final DateTime date;

  RoutineItem({
    @required this.type,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        title: Text(
          type,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.forward),
          onPressed: null,
        ),
      ),
    );
  }
}
