import 'dart:convert';
import 'package:enum_to_string/enum_to_string.dart';
import '../models/unity_weight.dart';
import '../models/series.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addSerieToExercise(String routineID, String exerciseID,
      double weigth, int repTotal, UnityWeight unityWeight) async {
    final url =
        'https://gym-proyect.firebaseio.com/routines/$routineID/$exerciseID.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'series': {
            'exerciseID': exerciseID,
            'weigth': weigth.toString(),
            'repTotal': repTotal.toString(),
            'unityWeight': EnumToString.parse(unityWeight),
          }
        }),
      );
      print(json.decode(response.body));
      listSeries.add(Series(
          exerciseID: exerciseID,
          id: json.decode(response.body)['name'],
          weigth: weigth,
          repTotal: repTotal,
          unityWeight: unityWeight));

      notifyListeners();
    } catch (error) {}
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
