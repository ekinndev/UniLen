import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../colors.dart';

class AnaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://ekinabalioglu.com/resimler/ekin.jpg'),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text('xD'),
                )
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [DanColor.felseDinRenk, DanColor.cogRenk],
              ),
            ),
          ),
          ListTile(
              leading: Icon(SimpleLineIcons.home), title: Text('Anasayfa')),
          ListTile(
              leading: Icon(SimpleLineIcons.pencil), title: Text('Dersler')),
          ListTile(
              leading: Icon(SimpleLineIcons.graduation),
              title: Text('Üniversiteler')),
          ListTile(
              leading: Icon(SimpleLineIcons.envelope), title: Text('İletişim')),
         
        ],
      ),
    );
  }
}
