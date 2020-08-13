import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../settings/constants.dart';
import '../settings/less_name.dart';
import '../widgets/ders_butonu.dart';
import '../widgets/drawer.dart';
import '../widgets/ust_ana_kart.dart';
import './ders_ozel_screen.dart';

class DersGenelSecim extends StatelessWidget {
  static const dersGenelSecimRoute = '/dersgenel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AnaDrawer(),
      appBar: AppBar(),
      body: buildColumnDersAna(context),
    );
  }

  Column buildColumnDersAna(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        UstAnaKart(
          icon: Entypo.open_book,
          subtitle: 'Tüm dersler bir tık uzağınızda.',
          title: 'Tüm Dersler',
          lottie: 'assets/lottie/study.json',
        ),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 15),
          children: <Widget>[
            tytBolumu(context),
            Constants.aralikHeight15,
            aytSayBolumu(context),
            Constants.aralikHeight15,
            aytEaBolumu(context),
            Constants.aralikHeight15,
            aytSozBolumu(context),
            Constants.aralikHeight15,
          ],
        ))
      ],
    );
  }

  Column tytBolumu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        dersBasligi('TYT DERSLERİ', context),
        Constants.aralikHeight15,
        dersButonlar(context, LessName.tytDersler),
      ],
    );
  }

  Column aytSayBolumu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        dersBasligi('AYT SAYISAL DERSLERİ', context),
        Constants.aralikHeight15,
        dersButonlar(context, LessName.sayDersler),
      ],
    );
  }

  Column aytEaBolumu(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dersBasligi('AYT EŞİT AĞIRLIK DERSLERİ', context),
          Constants.aralikHeight15,
          dersButonlar(context, LessName.eaDersler),
        ]);
  }

  Column aytSozBolumu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        dersBasligi('AYT SÖZEL DERSLERİ', context),
        Constants.aralikHeight15,
        dersButonlar(context, LessName.sozDersler),
      ],
    );
  }

  Padding dersBasligi(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(text, style: Theme.of(context).textTheme.headline3),
    );
  }

  Container dersButonlar(BuildContext context, List<dynamic> ders) {
    return Container(
      height: 70,
      child: ListView.builder(
        itemCount: ders.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) => DersButonu(
            (ders[i]['icon']),
            ders[i]['ad'],
            ders[i]['renk'],
            0,
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DersOzelScreen(),
                      settings: RouteSettings(arguments: ders[i])),
                )),
      ),
    );
  }
}
