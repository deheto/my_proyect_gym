import '../providers/routine.dart';
import 'package:uuid/uuid.dart';
import '../providers/routines_provider.dart';
import '../custom_widgets/exercise_model_item.dart';
import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRoutineScreen extends StatefulWidget {
  @override
  _CreateRoutineScreenState createState() => _CreateRoutineScreenState();
}

class _CreateRoutineScreenState extends State<CreateRoutineScreen>
    with SingleTickerProviderStateMixin {
  final uuid = Uuid();
  final _nameController = TextEditingController();
  final _filterControler = TextEditingController();
  var _showFavorites = false;
  var _filtExercise = false;
  var _showRoutineExercises = false;
  List<ExerciseModel> _favoriteListFiltered;
  List<ExerciseModel> _listExercise;
  ExerciseModelProvider _exerciseModelProvider;
  Routine _routine;

  @override
  void initState() {
    _routine = Routine(id: uuid.v4(), creationDate: DateTime.now());
    _exerciseModelProvider =
        Provider.of<ExerciseModelProvider>(context, listen: false);

    _listExercise = _exerciseModelProvider.listExerciseModel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
                onPressed: () {
                  _createRoutine();
                },
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
          constraints: BoxConstraints(maxHeight: deviceSize.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 40,
                margin:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Cantidad de ejercicios',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: 0.5,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showRoutineExercises
                              ? _showRoutineExercises = false
                              : _showRoutineExercises = true;
                        });
                      },
                      child: ChangeNotifierProvider.value(
                        value: _routine,
                        child: _ShowAmountExercises(),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: 0.5,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Center(child: _showRoutineExercise(deviceSize)),
              ),
              _showRoutineExercises
                  ? Divider(
                      color: Theme.of(context).dividerColor,
                    )
                  : Center(),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 40,
                      width: deviceSize.width,
                      margin: EdgeInsets.symmetric(
                          vertical: _showRoutineExercises ? 15.0 : 5,
                          horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        onChanged: (str) {
                          if (str.isNotEmpty) return;
                          print('EL STRING SE VACIOOO!!');

                          setState(() {
                            _filtExercise = false;
                            _listExercise =
                                _exerciseModelProvider.listExerciseModel;
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
              _showFavorites &&
                      _exerciseModelProvider.favoriteExerciseModelLenght <= 0
                  ? _filtExercise
                      ? Text(
                          'No se encontraron ejercicios con base a lo buscado, ¡intenta de nuevo!')
                      : Text('No hay ejercicios favoritos, ¡añade algunos!')
                  : _listExercise.length <= 0 &&
                              _exerciseModelProvider
                                      .favoriteExerciseModelLenght <=
                                  0 ||
                          _filtExercise && _favoriteListFiltered.length <= 0
                      ? Text(
                          'No se encontraron ejercicios con base a lo buscado, ¡intenta de nuevo!')
                      : Expanded(
                          child: GridView.builder(
                            itemBuilder: (ctx, i) =>
                                ChangeNotifierProvider.value(
                              value: _showFavorites
                                  ? _filtExercise
                                      ? _favoriteListFiltered[i]
                                      : _exerciseModelProvider
                                          .listFavoriteExerciseModel[i]
                                  : _listExercise[i],
                              child: ExerciseModelItem(_routine),
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
                                ? _exerciseModelProvider
                                    .favoriteExerciseModelLenght
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
      _filtExercise = true;
      _favoriteListFiltered = _exerciseModelProvider
          .filtFavoriteExerciseModel(_filterControler.text);
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

  Widget _showRoutineExercise(Size size) {
    return GestureDetector(
      child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: _showRoutineExercises
              ? MediaQuery.of(context).orientation == Orientation.portrait
                  ? size.height * 0.1
                  : size.height * 0.2
              : 0,
          width: double.infinity),
      onTap: () {
        setState(() {
          _showRoutineExercises
              ? _showRoutineExercises = false
              : _showRoutineExercises = true;
        });
      },
    );
  }

  void _createRoutine() {
    Provider.of<RoutinesProvider>(context).addRoutine(_routine);
  }
}

class _ShowAmountExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Consumer<Routine>(
        builder: (ctx, routine, child) => Center(
          child: Text(
            '${routine.getExerciseListLenght()}',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
