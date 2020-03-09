import 'package:flutter/material.dart';
import 'package:uniapp/screens/dersozel_screen.dart';
import 'package:uniapp/settings/colors.dart';
import 'package:uniapp/settings/icons.dart';
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                DersButonu(
                    (DanIcons.turkceIcon),
                    LessName.tytturkce['ad'],
                    DanColor.edebRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tytturkce['kod'])),
                        )),
                DersButonu(
                    (DanIcons.matIcon),
                    LessName.tytmat['ad'],
                    DanColor.matRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tytmat['kod'])),
                        )),
                DersButonu(
                    (DanIcons.fizikIcon),
                    LessName.tytfizik['ad'],
                    DanColor.fizikRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tytfizik['kod'])),
                        )),
                DersButonu(
                    (DanIcons.kimIcon),
                    LessName.tytkimya['ad'],
                    DanColor.kimRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tytkimya['kod'])),
                        )),
                DersButonu(
                    (DanIcons.bioIcon),
                    LessName.tytbio['ad'],
                    DanColor.bioRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tytbio['kod'])),
                        )),
                DersButonu(
                    (DanIcons.tarihIcon),
                    LessName.tyttarih['ad'],
                    DanColor.tarihRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tyttarih['kod'])),
                        )),
                DersButonu(
                    (DanIcons.cogIcon),
                    LessName.tytcog['ad'],
                    DanColor.cogRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tytcog['kod'])),
                        )),
                DersButonu(
                    (DanIcons.felseDinIcon),
                    LessName.tytfel['ad'],
                    DanColor.felseDinRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.tytfel['kod'])),
                        )),
              ],
            ),
          ),
          Text(
            'AYT SAYISAL KONULARI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                DersButonu(
                    (DanIcons.matIcon),
                    LessName.aytmat['ad'],
                    DanColor.matRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytmat['kod'])),
                        )),
                DersButonu(
                    (DanIcons.fizikIcon),
                    LessName.aytfiz['ad'],
                    DanColor.fizikRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytfiz['kod'])),
                        )),
                DersButonu(
                    (DanIcons.kimIcon),
                    LessName.aytkim['ad'],
                    DanColor.kimRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytkim['kod'])),
                        )),
                DersButonu(
                    (DanIcons.bioIcon),
                    LessName.aytbio['ad'],
                    DanColor.bioRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytbio['kod'])),
                        )),
              ],
            ),
          ),
          Text(
            'AYT EŞİT AĞIRLIK KONULARI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                DersButonu(
                    (DanIcons.turkceIcon),
                    LessName.aytedeb['ad'],
                    DanColor.edebRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytedeb['kod'])),
                        )),
                DersButonu(
                    (DanIcons.cogIcon),
                    LessName.aytcog1['ad'],
                    DanColor.cogRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytcog1['kod'])),
                        )),
                DersButonu(
                    (DanIcons.tarihIcon),
                    LessName.ayttar1['ad'],
                    DanColor.tarihRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.ayttar1['kod'])),
                        )),
                DersButonu(
                    (DanIcons.matIcon),
                    LessName.aytmat['ad'],
                    DanColor.matRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytmat['kod'])),
                        )),
              ],
            ),
          ),
          Text(
            'AYT SÖZEL KONULARI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                DersButonu((DanIcons.turkceIcon), LessName.aytedeb['ad'],
                    DanColor.edebRenk, 0),
                DersButonu(
                    (DanIcons.cogIcon),
                    LessName.aytcog1['ad'],
                    DanColor.cogRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytcog1['kod'])),
                        )),
                DersButonu(
                    (DanIcons.tarihIcon),
                    LessName.ayttar1['ad'],
                    DanColor.tarihRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.ayttar1['kod'])),
                        )),
                DersButonu(
                    (DanIcons.cogIcon),
                    LessName.aytcog2['ad'],
                    DanColor.cogRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.aytcog2['kod'])),
                        )),
                DersButonu((DanIcons.felseDinIcon), LessName.aytfel['ad'],
                    DanColor.felseDinRenk, 0),
                DersButonu(
                    (DanIcons.tarihIcon),
                    LessName.ayttar2['ad'],
                    DanColor.tarihRenk,
                    0,
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DersOzelScreen(),
                              settings: RouteSettings(
                                  arguments: LessName.ayttar2['kod'])),
                        )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
