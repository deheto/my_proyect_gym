import '../custom_widgets/exercise_model_item.dart';

import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoutineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listExercise =
        Provider.of<ExerciseModelProvider>(context, listen: false)
            .listExerciseModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crea tu rutina',
        ),
        textTheme: Theme.of(context).appBarTheme.textTheme,
      ),
      body: 
      SingleChildScrollView(
        child: 
        ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: 
                       Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
   
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ingrese el nombre de la rutina';
                      }
                      return null;
                    },
                   cursorWidth: 1,
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
                      labelText: '  Nombre de la rutina',
                      labelStyle: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: 35,
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                   Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: TextFormField(
                      cursorWidth: 1,
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.title,
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
                      labelText: '  Buscar ejercicios',
                      labelStyle: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: 35,
                ),
                 Divider(
                  color: Theme.of(context).dividerColor,
                ),
                Expanded(
                  child: GridView.builder(
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: listExercise[i],
                      child: ExerciseModelItem(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 10,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: listExercise.length,
                  ),
                  
                ),
              
              ],
            ),
          
        ),
    ),
    );
  }
}
