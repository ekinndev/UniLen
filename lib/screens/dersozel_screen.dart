import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/settings/colors.dart';
import 'package:uniapp/widgets/ustanakart.dart';
import '../providers/konu.dart';
import '../models/konu.dart';

class DersOzelScreen extends StatefulWidget {
  @override
  _DersOzelScreenState createState() => _DersOzelScreenState();
}

class _DersOzelScreenState extends State<DersOzelScreen> {
  @override
  Widget build(BuildContext context) {
    final key =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: dersOzelAppBar(),
      body: Column(
        children: <Widget>[
          UstAnaKart(
            subtitle: '10 Konu',
            title: key['ad'],
            icon: key['icon'].icon,
          ),
          Expanded(
            child: FutureBuilder<List<Konu>>(
                future: Provider.of<KonuProvider>(context, listen: false)
                    .degerleriCek(key['kod']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Consumer<KonuProvider>(
                    builder: (_, prov, child) {
                      return konularListView(snapshot.data, key['icon'].icon);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  ListView konularListView(List<Konu> konular, IconData icon) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (ctx, i) {
        return konuKart(i, konular[i], icon);
      },
      itemCount: konular.length,
    );
  }

  Card konuKart(int i, Konu ders, IconData icon) {
    final rengiBelirle = ders.durum == false ? Colors.black : DanColor.anaRenk;
    return Card(
      margin: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: i == 10 - 1 ? 15 : 8,
          top: i == 0 ? 15 : 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: rengiBelirle,
          size: 35,
        ),
        title: Text(
          ders.konu,
          textAlign: TextAlign.center,
          style: TextStyle(color: rengiBelirle, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
            onPressed: () {
              Provider.of<KonuProvider>(context, listen: false)
                  .durumuGuncelle(ders.id);
            },
            icon: Icon(
              SimpleLineIcons.check,
              color: rengiBelirle,
            )),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: rengiBelirle)),
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
