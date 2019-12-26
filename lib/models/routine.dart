import 'package:flutter/foundation.dart';

import 'exercise.dart';

class Routine {
  final String id;
  final DateTime date;
  final String type;
  List<Exercise> exercises = [];

  Routine({
    this.exercises,
    @required this.id,
    @required this.date,
    @required this.type,
  });
}
