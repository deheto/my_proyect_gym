import '../principal_views/principal_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTitle(String title, IconData icon, Function function) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
      ),
      onTap: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text('Historial'),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTitle(
            'Home',
            Icons.home,
            () {
               Navigator.of(context).pushReplacementNamed(PrincipalPage.routeName);
            },
          ),
          buildListTitle(
            'Historial',
            Icons.hdr_on,
            () {},
          ),
        ],
      ),
    );
  }
}
