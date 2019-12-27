import '../models/routine.dart';
import '../principal_views/routine_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoutineItem extends StatelessWidget {
  final Routine routine;

  RoutineItem({
    @required this.routine,
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
          routine.type,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(routine.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.forward),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(RoutineDetailsPage.routeName, arguments: 
             routine,
            );
          },
        ),
      ),
    );
  }
}
