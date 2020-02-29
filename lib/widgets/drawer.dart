import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../colors.dart';

class AnaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Ekin Abalıoğlu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('SAY'),
                        ),
                      ],
                    ),
                    accountEmail: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('ekinabalioglu@gmail.com'),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('Mezun'),
                        ),
                      ],
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://ekinabalioglu.com/resimler/ekin.jpg'),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [DanColor.felseDinRenk, DanColor.cogRenk],
                      ),
                    )),
                ListTile(
                    onTap: () {},
                    leading: Icon(SimpleLineIcons.home),
                    title: Text('Anasayfa')),
                ListTile(
                    onTap: () {},
                    leading: Icon(SimpleLineIcons.note),
                    title: Text('Dersler')),
                ListTile(
                    onTap: () {},
                    leading: Icon(SimpleLineIcons.graduation),
                    title: Text('Üniversiteler')),
                ListTile(
                    onTap: () {},
                    leading: Icon(SimpleLineIcons.pencil),
                    title: Text('Sınavlarım')),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                        leading: Icon(SimpleLineIcons.settings),
                        title: Text('Ayarlar')),
                    ListTile(
                        leading: Icon(SimpleLineIcons.envelope),
                        title: Text('İletişim'))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
