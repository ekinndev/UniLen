import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/settings/colors.dart';
import 'package:uniapp/settings/icons.dart';
import 'package:uniapp/widgets/ustanakart.dart';
import '../providers/konu.dart';

class DersOzelScreen extends StatefulWidget {
  @override
  _DersOzelScreenState createState() => _DersOzelScreenState();
}

class _DersOzelScreenState extends State<DersOzelScreen> {
  @override
  Widget build(BuildContext context) {
    final liste = Provider.of<KonuProvider>(context).degerleriCek;
    final key = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: dersOzelAppBar(),
      body: Column(
        children: <Widget>[
          UstAnaKart(
            subtitle: '10 Konu',
            title: 'TYT Fizik',
            icon: DanIcons.fizikIcon.icon,
          ),
          konularListView(liste),
        ],
      ),
    );
  }

  Expanded konularListView(List<Map<String, Object>> konular) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (ctx, i) {
          return konuKart(i, konular[i]);
        },
        itemCount: konular.length,
      ),
    );
  }

  Card konuKart(int i, Map<String, Object> ders) {
    return Card(
      margin: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: i == 10 - 1 ? 15 : 8,
          top: i == 0 ? 15 : 8),
      child: ListTile(
        leading: Icon(
          DanIcons.fizikIcon.icon,
          color: ders['durum'] == false ? Colors.black : DanColor.anaRenk,
          size: 35,
        ),
        title: Text(
          ders['konu'],
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ders['durum'] == false ? Colors.black : DanColor.anaRenk,
              fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
            onPressed: () {
              Provider.of<KonuProvider>(context, listen: false)
                  .durumuGuncelle(i);
            },
            icon: Icon(
              SimpleLineIcons.check,
              color: ders['durum'] == false ? Colors.black : DanColor.anaRenk,
            )),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: ders['durum'] == false
              ? BorderSide()
              : BorderSide(color: DanColor.anaRenk)),
    );
  }

  AppBar dersOzelAppBar() {
    return AppBar(
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
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }
}
