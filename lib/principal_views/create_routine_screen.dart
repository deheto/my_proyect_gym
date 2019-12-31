import '../custom_widgets/exercise_model_item.dart';

import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoutineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listExercise =
        Provider.of<ExerciseModelProvider>(context, listen: false).listExerciseModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crea tu rutina',
        ),
        textTheme: Theme.of(context).appBarTheme.textTheme,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.title,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ingrese el nombre de la rutina';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: "Ejemplo: Pierna/Hombro",
                    labelStyle: Theme.of(context).textTheme.title,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 60,
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: GridView.builder(
                  itemBuilder: (ctx, i) => ExerciseModelItem(listExercise[i]),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: listExercise.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
