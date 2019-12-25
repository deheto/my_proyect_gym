import 'package:flutter/foundation.dart';

class Routine {
  final String id;
  final DateTime date;
  final String type;

  const Routine({
    @required this.id,
    @required this.date,
    @required this.type,
  });
}
