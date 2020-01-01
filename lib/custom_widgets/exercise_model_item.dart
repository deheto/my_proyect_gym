import 'package:provider/provider.dart';
import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseModelItem extends StatefulWidget {
  @override
  _ExerciseModelItemState createState() => _ExerciseModelItemState();
}

class _ExerciseModelItemState extends State<ExerciseModelItem> {


  @override
  Widget build(BuildContext context) {
    final exerciseModel = Provider.of<ExerciseModel>(context, listen: false);
    return ClipRRect(
      child: GridTile(
        child: Image.network(exerciseModel.imageURL, fit: BoxFit.cover),
        footer: Container(
          height: 40,
          child: GestureDetector(
            onTap: () {
              setState(() {
                exerciseModel.changeChosenStatus();
              });

              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content:  exerciseModel.isChosen
                      ? Text(
                          'Ejercicio añadido a la rutina.',
                        )
                      : Text(
                          'Ejercicio eliminado de la rutina.',
                        ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: GridTileBar(
              backgroundColor:  exerciseModel.isChosen ? Colors.black12 : Colors.black87,
              leading: Consumer<ExerciseModel>(
                builder: (ctx, exercise, _) => IconButton(
                  icon: Icon(
                    exercise.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    exercise.changeFavoriteStatus();

                    Provider.of<ExerciseModelProvider>(context)
                        .addExerciseToFavorite(exerciseModel);

                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: exercise.isFavorite
                            ? Text(
                                'Ejercicio añadido a favoritos.',
                              )
                            : Text(
                                'Ejercicio eliminado de favoritos.',
                              ),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                exerciseModel.name,
                textAlign: TextAlign.center,
              ),
              //* SHOW INFO
              trailing: IconButton(
                icon: Icon(Icons.info),
                onPressed: () {},
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: GridTile(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushNamed(
//               ProductDetailScreen.routeName,
//               arguments: product.id,
//             );
//           },
//           child: Image.network(
//             product.imageUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//         footer:

//         ),
//       ),
//     );
