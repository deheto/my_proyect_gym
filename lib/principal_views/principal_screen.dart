import 'dart:async';
import '../principal_views/history_screen.dart';
import '../custom_widgets/fancy_bottom_navigator.dart';
import '../custom_widgets/main_drawer.dart';
import '../principal_views/routines_screen.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  static const routeName = '/principal-page';

  @override
  _StatePrincipalPage createState() => _StatePrincipalPage();
}

class _StatePrincipalPage extends State<PrincipalPage> {
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  var index = 0;

  PageController pageController = PageController(initialPage: 0);


  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
       'Home',
        ),
      ),
      drawer: MainDrawer(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          HistoryOverView(),
          Center(
            child: Text('ss'),
          ),
          Center(
            child: Text('Security'),
          ),
          Center(
            child: Text('Message'),
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              backgroundColor: Theme.of(context).primaryColor,
              activeColor: Theme.of(context).bottomAppBarColor,
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(

                    icon: Icon(Icons.event), title: Text('Historial'),),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.equalizer), title: Text('Estadisticas', style: TextStyle(
                      fontSize: 11
                    ),)),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.fitness_center), title: Text('Rutina')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.details), title: Text('Detalles')),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}
