import 'package:flutter/material.dart';
import 'package:uniapp/settings/colors.dart';
import 'package:uniapp/settings/icons.dart';
import '../widgets/drawer.dart';
import '../widgets/dersbutonu.dart';

class DersGenelSecim extends StatelessWidget {
  static const dersGenelSecimRoute = '/dersgenel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AnaDrawer(),
      appBar: AppBar(
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
                    (DanIcons.turkceIcon), 'Tyt Türkçe', DanColor.edebRenk, 0),
                DersButonu(
                    (DanIcons.matIcon), 'Tyt Matematik', DanColor.matRenk, 0),
                DersButonu(
                    (DanIcons.fizikIcon), 'Tyt Fizik', DanColor.fizikRenk, 0),
                DersButonu(
                    (DanIcons.kimIcon), 'Tyt Kimya', DanColor.kimRenk, 0),
                DersButonu(
                    (DanIcons.bioIcon), 'Tyt Biyoloji', DanColor.bioRenk, 0),
                DersButonu(
                    (DanIcons.tarihIcon), 'Tyt Tarih', DanColor.tarihRenk, 0),
                DersButonu(
                    (DanIcons.cogIcon), 'Tyt Coğrafya', DanColor.cogRenk, 0),
                DersButonu((DanIcons.felseDinIcon), 'Tyt Felsefe ve Din',
                    DanColor.felseDinRenk, 0),
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
                    (DanIcons.matIcon), 'AYT Matematik', DanColor.matRenk, 0),
                DersButonu(
                    (DanIcons.fizikIcon), 'Ayt Fizik', DanColor.fizikRenk, 0),
                DersButonu(
                    (DanIcons.kimIcon), 'Ayt Kimya', DanColor.kimRenk, 0),
                DersButonu(
                    (DanIcons.bioIcon), 'Ayt Biyoloji', DanColor.bioRenk, 0),
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
                DersButonu((DanIcons.turkceIcon), 'Ayt Edebiyat',
                    DanColor.edebRenk, 0),
                DersButonu(
                    (DanIcons.cogIcon), 'Ayt Coğrafya-1', DanColor.cogRenk, 0),
                DersButonu(
                    (DanIcons.tarihIcon), 'Ayt Tarih', DanColor.tarihRenk, 0),
                DersButonu(
                    (DanIcons.cogIcon), 'Ayt Coğrafya-2', DanColor.cogRenk, 0),
                DersButonu((DanIcons.felseDinIcon), 'Ayt Felsefe ve Din',
                    DanColor.felseDinRenk, 0),
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
                DersButonu((DanIcons.turkceIcon), 'Ayt Edebiyat',
                    DanColor.edebRenk, 0),
                DersButonu(
                    (DanIcons.cogIcon), 'Ayt Coğrafya-1', DanColor.cogRenk, 0),
                DersButonu(
                    (DanIcons.tarihIcon), 'Ayt Tarih', DanColor.tarihRenk, 0),
                DersButonu(
                    (DanIcons.cogIcon), 'Ayt Coğrafya-2', DanColor.cogRenk, 0),
                DersButonu((DanIcons.felseDinIcon), 'Ayt Felsefe ve Din',
                    DanColor.felseDinRenk, 0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
