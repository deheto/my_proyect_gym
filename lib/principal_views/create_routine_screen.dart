import '../principal_views/principal_screen.dart';
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
  var _nameIncorrect = false;
  // var _showRoutineExercises = false;
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
  void dispose() {
    _filterControler.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(child: _filterButton()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 40.0,
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
      body: ListView(
        children: <Widget>[
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            child: TextFormField(
              controller: _nameController,
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.title,
              cursorWidth: 1,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: _nameIncorrect
                        ? Colors.red
                        : Theme.of(context).accentColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: _nameIncorrect ? Colors.red : Colors.white,
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
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Center(
              child: ChangeNotifierProvider.value(
                value: _routine,
                child: _showRoutineExercise(deviceSize),
              ),
            ),
          ),
      
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  height: 40,
                  width: deviceSize.width,
                  margin: EdgeInsets.symmetric(
                      vertical: _routine.getExerciseListLenght() > 0 ? 15.0 : 5,
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

                      _filterLists();
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

                    _filterLists();
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
                  ? _showMessageContainer(
                      'No se encontraron ejercicios con base a lo buscado, ¡intenta de nuevo!')
                  : _showMessageContainer(
                      'No hay ejercicios favoritos, ¡añade algunos!')
              : _listExercise.length <= 0 &&
                          _exerciseModelProvider.favoriteExerciseModelLenght <=
                              0 ||
                      _filtExercise && _favoriteListFiltered.length <= 0
                  ? _showMessageContainer(
                      'No se encontraron ejercicios con base a lo buscado, ¡intenta de nuevo!')
                  : _showListOfExercises(deviceSize),
        ],
      ),
    );
  }

  Widget _showListOfExercises(Size deviceSize) {
    return Container(
      height: deviceSize.height / 2,
      child: GridView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: _showFavorites
              ? _filtExercise
                  ? _favoriteListFiltered[i]
                  : _exerciseModelProvider.listFavoriteExerciseModel[i]
              : _listExercise[i],
          child: ExerciseModelItem(_routine),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 10
                  : 18,
          crossAxisSpacing: 0,
          mainAxisSpacing: 15,
        ),
        itemCount: _showFavorites
            ? _exerciseModelProvider.favoriteExerciseModelLenght
            : _listExercise.length,
      ),
    );
  }

  Widget _showMessageContainer(String msg) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          msg,
          style: Theme.of(context).textTheme.body2,
        ),
      ),
    );
  }

  void _filterLists() {
    setState(() {
      _filtExercise = true;
      _favoriteListFiltered = _exerciseModelProvider
          .filtFavoriteExerciseModel(_filterControler.text);
      _listExercise =
          _exerciseModelProvider.filterExerciseModel(_filterControler.text);
    });
  }

  Widget _filterButton() {
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
    return Consumer<Routine>(
      builder: (ctx, rout, ch) => AnimatedContainer(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _routine.getExerciseListLenght() > 0
            ? MediaQuery.of(context).orientation == Orientation.portrait
                ? size.height * 0.1 + 30
                : size.height * 0.2 + 30
            : 0,
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (ctx, i) => Card(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 3.0, 2.0, 5.0),
              child: ListTile(
                leading: Container(
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${1 + i}',
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                ),
                title: Text(
                  rout.getListExercises[i].name,
                  style: Theme.of(context).textTheme.display1,
                ),
                trailing: FlatButton(
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    _exerciseModelProvider.unChosenExercise(
                        rout.getListExercises[i].exerciseModelID);

                    setState(() {
                      _routine.removeExercise(i);
                    });
                  },
                ),
              ),
            ),
          ),
          itemCount: _routine.getExerciseListLenght(),
        ),
      ),
    );
  }

  void _createRoutine() {
    if (_nameController.text.isNotEmpty) {
      setState(() {
        _nameIncorrect = false;
      });

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Center(
            child: Text(
              '¿Todo listo?',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          content: Text(
            '¿Ya añadiste todos los ejercicios?',
            style: Theme.of(context).textTheme.body1,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                '¡Me faltan algunos!',
                style: Theme.of(context).textTheme.display1,
              ),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            FlatButton(
              child: Text(
                '¡Sí, ya terminé!',
                style: Theme.of(context).textTheme.display1,
              ),
              onPressed: () async {
                await Provider.of<RoutinesProvider>(context, listen: false)
                    .addRoutine(_routine);
                Navigator.of(context).pushNamed(PrincipalPage.routeName);
              },
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _nameIncorrect = true;
      });
    }
  }
}
