import 'package:flutter/material.dart';
import 'package:uniapp/screens/dersozel_screen.dart';
import 'package:uniapp/settings/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/dersbutonu.dart';
import '../settings/lessname.dart';

class DersGenelSecim extends StatelessWidget {
  static const dersGenelSecimRoute = '/dersgenel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AnaDrawer(),
      appBar: AppBar(
        backgroundColor: DanColor.anaRenk,
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.search),
          SizedBox(
            width: 15,
          ),
          Icon(Icons.notifications_none),
          SizedBox(
            width: 5,
          ),
        ],
        elevation: 0,
        title: Text(
          'Genel Dersler',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'TYT KONULARI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => DersButonu(
                  (LessName.tytDersler[i]['icon']),
                  LessName.tytDersler[i]['ad'],
                  LessName.tytDersler[i]['renk'],
                  0,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings: RouteSettings(
                                arguments: LessName.tytDersler[i]['kod'])),
                      )),
              itemCount: LessName.tytDersler.length,
            ),
          ),
          Text(
            'AYT SAYISAL KONULARI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            height: 70,
            child: ListView.builder(
              itemCount: LessName.sayDersler.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => DersButonu(
                  (LessName.sayDersler[i]['icon']),
                  LessName.sayDersler[i]['ad'],
                  LessName.sayDersler[i]['renk'],
                  0,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings: RouteSettings(
                                arguments: LessName.sayDersler[i]['kod'])),
                      )),
            ),
          ),
          Text(
            'AYT EŞİT AĞIRLIK KONULARI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            height: 70,
            child: ListView.builder(
              itemCount: LessName.eaDersler.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => DersButonu(
                  (LessName.eaDersler[i]['icon']),
                  LessName.eaDersler[i]['ad'],
                  LessName.eaDersler[i]['renk'],
                  0,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings: RouteSettings(
                                arguments: LessName.eaDersler[i]['kod'])),
                      )),
            ),
          ),
          Text(
            'AYT SÖZEL KONULARI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            height: 70,
            child: ListView.builder(
              itemCount: LessName.sozDersler.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => DersButonu(
                  (LessName.sozDersler[i]['icon']),
                  LessName.sozDersler[i]['ad'],
                  LessName.sozDersler[i]['renk'],
                  0,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings: RouteSettings(
                                arguments: LessName.sozDersler[i]['kod'])),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
