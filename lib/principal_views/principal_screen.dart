
import '../principal_views/routines_screen.dart';
import 'package:flutter/material.dart';


class PrincipalPage extends StatefulWidget {

   static const routeName = '/principal-page';


  @override
  _StatePrincipalPage createState() => _StatePrincipalPage();
}

class _StatePrincipalPage extends State<PrincipalPage> {
  int _selectedIndex = 0;
  final _pageOptions = [
    RoutinesPage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Theme.of(context).primaryColor))),
        child: BottomNavigationBar(
          items: itemsListButtonBar,
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).accentColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  static const List<BottomNavigationBarItem> itemsListButtonBar =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.fitness_center),
      title: Text('Entrenamiento'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_dining),
      title: Text('Dieta'),
    ),
  ];
}
