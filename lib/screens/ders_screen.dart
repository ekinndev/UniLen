import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniapp/screens/dersozel_screen.dart';
import 'package:uniapp/settings/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/dersbutonu.dart';
import '../settings/lessname.dart';
import '../widgets/ustanakart.dart';

class DersGenelSecim extends StatelessWidget {
  static const dersGenelSecimRoute = '/dersgenel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AnaDrawer(),
      appBar: dersAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          UstAnaKart(
              icon: Entypo.open_book,
              subtitle: 'Tüm dersler bir tık uzağınızda.',
              title: 'Tüm Dersler'),
          Expanded(
              child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: <Widget>[
              dersBasligi('TYT KONULARI'),
              SizedBox(height: 15),
              tytButonlar(context),
              SizedBox(height: 15),
              dersBasligi('AYT SAYISAL KONULARI'),
              SizedBox(height: 15),
              aytSayisalButonlar(context),
              SizedBox(height: 15),
              dersBasligi('AYT EŞİT AĞIRLIK KONULARI'),
              SizedBox(height: 15),
              aytEaButonlar(context),
              SizedBox(height: 15),
              dersBasligi('AYT SÖZEL KONULARI'),
              SizedBox(height: 15),
              aytSozelButonlar(context),
              SizedBox(height: 15),
            ],
          ))
        ],
      ),
    );
  }

  Padding dersBasligi(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
    );
  }

  Container tytButonlar(BuildContext context) {
    return Container(
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
                      settings:
                          RouteSettings(arguments: LessName.tytDersler[i])),
                )),
        itemCount: LessName.tytDersler.length,
      ),
    );
  }

  Container aytSozelButonlar(BuildContext context) {
    return Container(
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
                      settings:
                          RouteSettings(arguments: LessName.sozDersler[i])),
                )),
      ),
    );
  }

  Container aytEaButonlar(BuildContext context) {
    return Container(
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
                      settings:
                          RouteSettings(arguments: LessName.eaDersler[i])),
                )),
      ),
    );
  }

  Container aytSayisalButonlar(BuildContext context) {
    return Container(
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
                      settings:
                          RouteSettings(arguments: LessName.sayDersler[i])),
                )),
      ),
    );
  }

  AppBar dersAppBar() {
    return AppBar(
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
    );
  }
}
