import '../custom_widgets/exercise_model_item.dart';

import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoutineScreen extends StatefulWidget {
  @override
  _CreateRoutineScreenState createState() => _CreateRoutineScreenState();
}

class _CreateRoutineScreenState extends State<CreateRoutineScreen> {
  final _nameController = TextEditingController();
  final _filterControler = TextEditingController();
  var _showFavorites = false;
  List<ExerciseModel> _listExercise;
  List<ExerciseModel> _favoriteList;
  ExerciseModelProvider _exerciseModelProvider;

  @override
  void initState() {
    _exerciseModelProvider =
        Provider.of<ExerciseModelProvider>(context, listen: false);

    _listExercise = _exerciseModelProvider.listExerciseModel;
    _favoriteList = _exerciseModelProvider.listFavoriteExerciseModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(child: filterButton(context)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 40,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: TextFormField(
                  controller: _nameController,
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
              ),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        onChanged: (str) {
                          if (str.isNotEmpty) return;
                          print('EL STRING SE VACIOOO!!');

                          setState(() {
                            _listExercise =
                                _exerciseModelProvider.listExerciseModel;
                            _favoriteList = _exerciseModelProvider
                                .listFavoriteExerciseModel;
                          });
                        },
                        onFieldSubmitted: (str) {
                          if (str.isEmpty) return;
                          filterLists();
                        },
                        controller: _filterControler,
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
                          labelText: '  Ejercicios o Parte del Cuerpo',
                          labelStyle: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        if (_filterControler.text.isEmpty) return;

                        filterLists();
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              _showFavorites && _favoriteList.length <= 0
                  ? Text('No hay ejercicios favoritos, ¡añade algunos!')
                  : _listExercise.length <= 0
                      ? Text('No se encontraron ejercicios')
                      : Expanded(
                          child: GridView.builder(
                            itemBuilder: (ctx, i) =>
                                ChangeNotifierProvider.value(
                              value: _showFavorites
                                  ? _favoriteList[i]
                                  : _listExercise[i],
                              child: ExerciseModelItem(),
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 10
                                      : 18,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 15,
                            ),
                            itemCount: _showFavorites
                                ? _favoriteList.length
                                : _listExercise.length,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  void filterLists() {
    setState(() {
      _favoriteList = _exerciseModelProvider
          .filterFavoriteExerciseModel(_filterControler.text);
      _listExercise =
          _exerciseModelProvider.filterExerciseModel(_filterControler.text);
    });
  }

  Widget filterButton(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
          icon: Icon(
            _showFavorites ? Icons.favorite : Icons.favorite_border,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            setState(() {
              _showFavorites ? _showFavorites = false : _showFavorites = true;
            });
          }),
    );
  }
}
