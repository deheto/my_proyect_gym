import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/htpp_exception.dart';
import '../models/series.dart';
import '../models/unity_weight.dart';

class ExerciseUser with ChangeNotifier {
  final String routineID;
  final String id;
  final String name;
  List<Series> listSeries = [];

  List<Series> get series {
    return [...listSeries];
  }

  ExerciseUser.fromDB({
    @required this.id,
    @required this.routineID,
    @required this.name,
    @required this.listSeries,
  });

  ExerciseUser({
    @required this.id,
    @required this.routineID,
    @required this.name,
  });

  void addSerie(Series serie) {
    listSeries.add(serie);
  }

  Future<void> addSerieToExercise(String exerciseID, double weigth,
      int repTotal, UnityWeight unityWeight) async {
    final url = 'https://gym-proyect.firebaseio.com/series.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'exerciseID': exerciseID,
          'weigth': weigth.toString(),
          'repTotal': repTotal.toString(),
          'unityWeight': EnumToString.parse(unityWeight),
        }),
      );
      // print(json.decode(response.body));
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

  Future<void> deleteSerie(int index) async {
    
    var serie = listSeries.elementAt(index);
    var url = 'https://gym-proyect.firebaseio.com/series/${serie.id}.json';

    listSeries.removeAt(index);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      listSeries.insert(index, serie);
      notifyListeners();
      throw HttpException('No se pudo eliminar el ejercicio.');
    }

    serie = null;
  }
}
