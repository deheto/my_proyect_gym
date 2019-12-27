import '../custom_widgets/main_drawer.dart';
import '../principal_views/routines_screen.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  static const routeName = '/principal-page';

  @override
  _StatePrincipalPage createState() => _StatePrincipalPage();
}

class _StatePrincipalPage extends State<PrincipalPage> {
  final List<Map<String, Object>> _pages = [
    {
      'page': RoutinesPage(),
      'title': 'Rutinas',
    },
    {
      'page': RoutinesPage(),
      'title': 'Rutinas',
    },
  ];

  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectPageIndex]['title'],
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        // unselectedItemColor: Colors.red,
        // selectedItemColor: Theme.of(context).accentColor,
        onTap: _selectPage,
        currentIndex: _selectPageIndex,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text('Historial'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text('Historial'),
          )
        ],
      ),
    );
  }
}
