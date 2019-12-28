import '../models/unity_weight.dart';
import '../models/series.dart';
import 'package:flutter/foundation.dart';

class Exercise with ChangeNotifier {
  final String routineID;
  final String id;
  final String name;
  List<Series> listSeries = [];

  List<Series> get series {
    return [...listSeries];
  }

  Exercise.fromDB({
    @required this.id,
    @required this.routineID,
    @required this.name,
   @required this.listSeries,
  });

   Exercise({
    @required this.id,
    @required this.routineID,
    @required this.name,

  });



  void addSerieToExercise(String exerciseID, String id, double weigth,
      int repTotal, UnityWeight unityWeight) {
    listSeries.add(Series(
        exerciseID: exerciseID,
        id: id,
        weigth: weigth,
        repTotal: repTotal,
        unityWeight: unityWeight));
    notifyListeners();
  }

  double totalWeight() {
    double amount = 0;

    if (listSeries != null) {
      for (var item in listSeries) {
        amount += item.repTotal * item.weigth;
      }
    }
    return amount;
  }

  void deleteSerie(int index) {
    listSeries.removeAt(index);
    notifyListeners();
  }
}
