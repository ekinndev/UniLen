import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../screens/uni_screen.dart';
import '../settings/colors.dart';
import '../screens/ders_screen.dart';

class AnaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(
              'Ekin Abalıoğlu',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('ekinabalioglu@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://ekinabalioglu.com/resimler/ekin.jpg'),
            ),
            decoration: BoxDecoration(
              color: DanColor.anaRenk,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                    onTap: () => Navigator.pushNamed(context, "/"),
                    leading: Icon(SimpleLineIcons.home),
                    title: Text('Anasayfa')),
                ListTile(
                    onTap: () => Navigator.pushNamed(
                        context, DersGenelSecim.dersGenelSecimRoute),
                    leading: Icon(SimpleLineIcons.note),
                    title: Text('Dersler')),
                ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, UniScreen.uniScreenRoute),
                    leading: Icon(SimpleLineIcons.graduation),
                    title: Text('Üniversiteler')),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 0,
                    ),
                    ListTile(
                      leading: Icon(MaterialCommunityIcons.exit_to_app),
                      title: Text('Çıkış Yap'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(SimpleLineIcons.envelope),
                      title: Text('İletişim'),
                      onTap: () {},
                    ),
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
