import 'package:flutter/foundation.dart';

class ExerciseModel {
  final String name;
  final String imageURL;
  final String description;
  final List<String> bodyParts;
  bool isFavorite;
  bool isFromUser;
  ExerciseModel({
    @required this.name,
    @required this.bodyParts,
    @required this.description,
    @required this.imageURL,
    this.isFavorite = false,
    this.isFromUser = false,
  });

  void changeFavorite(bool newStatus) {
    isFavorite ? isFavorite = false : isFavorite = true;
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
      imageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_Ao20yGlvhBPVbhrY7XM_DuVT2Tm5xs351AiVdTQkTSS834od&s',
      bodyParts: [
        'Gluteo',
        'Cuadriceps',
        'Femoral',
      ],
      description: 'Pa que saque nalgas',
      name: 'Hip Thrust',
    ),

    ExerciseModel(
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
}
