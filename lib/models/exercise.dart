import 'package:flutter/foundation.dart';

import 'series.dart';

class Exercise {

  final String routineID;
  final String id;
  final String name;
  List<Series> listSeries = [];

  List<Series> get series {
    return listSeries;
  }

  Exercise({
    this.id,
     @required this.routineID,
    @required this.name,
    this.listSeries,
  });
}
