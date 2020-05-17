import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/screens/ana_screen.dart';
import '../screens/uni_screen.dart';
import '../screens/ders_screen.dart';
import '../providers/auth.dart';

class AnaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProv = Provider.of<Auth>(context, listen: false);
    final _user = _authProv.user;

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(
              _user.name,
              style: Theme.of(context).textTheme.headline2,
            ),
            accountEmail: Text(
              _user.email,
              style: Theme.of(context).textTheme.headline4,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage:   CachedNetworkImageProvider(_user.photoUrl),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                    onTap: () => Navigator.popAndPushNamed(
                        context, AnaEkran.anaEkranRoute),
                    leading: Icon(SimpleLineIcons.home),
                    title: Text('Anasayfa',
                        style: Theme.of(context).textTheme.bodyText2)),
                ListTile(
                    onTap: () => Navigator.popAndPushNamed(
                        context, DersGenelSecim.dersGenelSecimRoute),
                    leading: Icon(SimpleLineIcons.note),
                    title: Text('Dersler',
                        style: Theme.of(context).textTheme.bodyText2)),
                ListTile(
                    onTap: () => Navigator.popAndPushNamed(
                        context, UniScreen.uniScreenRoute),
                    leading: Icon(SimpleLineIcons.graduation),
                    title: Text('Üniversiteler',
                        style: Theme.of(context).textTheme.bodyText2)),
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
                      title: Text('Çıkış Yap',
                          style: Theme.of(context).textTheme.bodyText2),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/');
                        Provider.of<Auth>(context, listen: false).signOutAll();
                      },
                    ),
                    ListTile(
                      leading: Icon(SimpleLineIcons.envelope),
                      title: Text('İletişim',
                          style: Theme.of(context).textTheme.bodyText2),
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
