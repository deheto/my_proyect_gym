import 'package:flutter/foundation.dart';

import 'series.dart';

class Exercise{

  final String id;
  final String name;
  final List<Series> listSeries;

  Exercise({
     @required this.id,
    @required this.name,
    @required this.listSeries,
  });

}