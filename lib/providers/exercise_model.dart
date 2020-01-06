import 'package:flutter/foundation.dart';

class ExerciseModel with ChangeNotifier {
  final String id;
  final String name;
  final String imageURL;
  final String description;
  final List<String> bodyParts;
  bool isChosen;
  bool isFavorite;
  bool isFromUser;
  ExerciseModel({
    @required this.id,
    @required this.name,
    @required this.bodyParts,
    @required this.description,
    @required this.imageURL,
    this.isFavorite = false,
    this.isFromUser = false,
    this.isChosen = false,
  });

  void changeFavoriteStatus() {
    isFavorite ? isFavorite = false : isFavorite = true;
    notifyListeners();
  }

  bool hasThatTypeOfBodyPart(String filter) {
    var contains = false;
    bodyParts.forEach((f) {
      if (f.contains(filter) || f.endsWith(filter)) contains = true;
    });

    return contains;
  }

  int get bodyPartsLenght {
    return bodyParts.length;
  }

  String get getBodyPartsString {
    var txt = '';
    bodyParts.forEach((f) {
      txt += '-$f\n';
    });
 
    return txt;
  }

  void changeChosenStatus() {
    isChosen ? isChosen = false : isChosen = true;
    notifyListeners();
  }

  void addBodyPart(String bodyPart) {
    bodyParts.add(bodyPart);
  }

  void deleteBodyPart(int index) {
    bodyParts.removeAt(index);
  }
}

class ExerciseModelProvider with ChangeNotifier {
  List<ExerciseModel> _listExerciseModel = [
    ExerciseModel(
      id: '1',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkAY_rC-NYfS9bDkuxiXMWmVybk0ty2F6ouM_9Wk5u1rzAwBEmXg&s',
      bodyParts: [
        'Pectoral',
        'Triceps',
        'Deltoide',
      ],
      description: 'Empuje duro para que no se cague.',
      name: 'Press Banca Plano',
    ),
    ExerciseModel(
      id: '2',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_Ao20yGlvhBPVbhrY7XM_DuVT2Tm5xs351AiVdTQkTSS834od&s',
      bodyParts: [
        'Gluteo',
        'Cuadriceps',
        'Femoral',
      ],
      description: 'Pa que saque nalgas',
      name: 'Hip Thrust',
    ),
    ExerciseModel(
      id: '3',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKKiM_5guhLGtwBdEBg3B5M5kzUQQeOIa5u3XFo6Tfr_KXSWSsqQ&s',
      bodyParts: [
        'Dorsales',
        'Biceps',
      ],
      description: 'Jale para abajo.',
      name: 'Dominadas',
    ),
  ];

  List<ExerciseModel> get listExerciseModel {
    return _listExerciseModel;
  }

  List<ExerciseModel> get copyListExerciseModel {
    return [..._listExerciseModel];
  }

  List<ExerciseModel> get listFavoriteExerciseModel {
    final List<ExerciseModel> filterList = [];

    _listExerciseModel.forEach((exe) {
      if (exe.isFavorite) {
        filterList.add(exe);
      }
    });

    return filterList;
  }


  int get favoriteExerciseModelLenght {
    return _listExerciseModel.where((ex) => ex.isFavorite).toList().length;
  }


  
  List<ExerciseModel> filtFavoriteExerciseModel(String filter) {
    final List<ExerciseModel> filterList = [];

    _listExerciseModel.forEach((exe) {
      if (exe.isFavorite && exe.name.contains(filter) ||
          exe.name.endsWith(filter) ||
          exe.hasThatTypeOfBodyPart(filter)) {
        filterList.add(exe);
      }
    });

    return filterList;
  }

  List<ExerciseModel> filterExerciseModel(String filter) {
    final List<ExerciseModel> filterList = [];

    _listExerciseModel.forEach((exe) {
      if (exe.name.contains(filter) ||
          exe.name.endsWith(filter) ||
          exe.hasThatTypeOfBodyPart(filter)) {
        filterList.add(exe);
      }
    });

    return filterList;
  }

  ExerciseModel findExerciseByID(String id) {
    return _listExerciseModel.firstWhere((exe) => exe.id == id);
  }

  void unChosenExercise(String id){

      final exercise = findExerciseByID(id);
        print("EL EJERCICIO  TIENE QUE CAMBIAR " + exercise.id );

      exercise.changeChosenStatus();
   
  }

}
