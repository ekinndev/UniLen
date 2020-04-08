import 'package:flutter/material.dart';
import 'package:uniapp/settings/colors.dart';

class UniversiteDetail extends StatelessWidget {
  static const universiteDetailRoute = '/unidetail';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[IconButton(icon: Icon(Icons.search),onPressed: (){},)],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: <Widget>[
            UstUniAnaKart(
              icon: Icons.ac_unit,
              subtitle: 'Denizli - Devlet',
              title: 'Pamukkale Üniversitesi',
            ),
            Expanded(child: Text(''),),
          ],
        ),
      ),
    );
  }
}

class UstUniAnaKart extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  UstUniAnaKart({this.title, this.subtitle, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.32,
      width: double.infinity,
      decoration: BoxDecoration(
        color: DanColor.anaRenk,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset('assets/logolar/168.png', fit: BoxFit.cover),
            radius: 55,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 35),
          ),
          Text(subtitle, style: TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}
