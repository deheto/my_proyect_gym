import 'package:denis_proyect/providers/routine.dart';

import '../providers/routines_provider.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/routine_item.dart';
import 'package:flutter/material.dart';



class RoutinesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
      * ! ARREGLAR EL TAMAÑO QUE TOMA LA LISTA      
      */

    final routinesData = Provider.of<RoutinesProvider>(context);
    final routines = routinesData.routines;

    return Container(
      height: 500,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
       value: routines[index],
          child: RoutineItem(), 
        ),
        addAutomaticKeepAlives: false,
        itemCount: routines.length,
      ),
    );
  }
}
