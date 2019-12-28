import '../custom_widgets/routines_listview.dart';

import 'package:flutter/material.dart';

class RoutinesPage extends StatelessWidget {
  static const routeName = '/routine-page';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: RoutinesListView(),
    );
  }
}
