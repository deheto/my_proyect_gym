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

     print(" BODY PART ENCONTRADA = $contains");
   
    return contains;
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
  List<ExerciseModel> _favoriteList = [];

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
    return [..._listExerciseModel];
  }

  List<ExerciseModel> get listFavoriteExerciseModel {
    return [..._favoriteList];
  }

  List<ExerciseModel> filterExerciseModel(String filter) {
    return _listExerciseModel
        .where((exe) => exe.name.contains(filter)|| exe.name.endsWith(filter) || exe.hasThatTypeOfBodyPart(filter))
        .toList();
  }

  List<ExerciseModel> filterFavoriteExerciseModel(String filter) {
    return _favoriteList
        .where((exe) =>
            exe.name.contains(filter) || exe.name.endsWith(filter) || exe.hasThatTypeOfBodyPart(filter))
        .toList();
  }

  void addExerciseToFavorite(ExerciseModel exerciseModel) {
    final exercise = _favoriteList
        .firstWhere((exe) => exe.id == exerciseModel.id, orElse: () => null);

    if (exercise == null) {
      _favoriteList.add(exerciseModel);
    } else {
      _favoriteList.removeWhere((exe) => exe.id == exerciseModel.id);
    }
  }
}
