import '../providers/routine.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PreviewDescriptionRoutine extends StatelessWidget {
  final int index;
  final String routineName;
  PreviewDescriptionRoutine(this.index,this.routineName);

  @override
  Widget build(BuildContext context) {
    // final loadedRoutine = Provider.of<Routine>(context, listen: false);
    var i = index + 1;

    return Row(
      
      children: <Widget>[
        CircleAvatar(
          child: Text(
            '$i',
          ),
        ),
        SizedBox(width: 15,),
        Text(
          routineName,
          style: Theme.of(context).textTheme.display4,
        ),
      ],
    );

  }
}
