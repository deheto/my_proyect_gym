import 'package:flutter/cupertino.dart';
import 'unity_weight.dart';

class Series {
  final String exerciseID;
  final String id;
  final double weigth;
  final int repTotal;
  UnityWeight unityWeight;

  Series({
    @required this.exerciseID,
    @required this.id,
    @required this.weigth,
    @required this.repTotal,
    @required this.unityWeight,
  });
}
