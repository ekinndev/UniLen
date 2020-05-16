import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/settings/colors.dart';
import '../widgets/ust_ana_kart.dart';
import '../providers/konu.dart';
import '../models/konu.dart';

class DersOzelScreen extends StatefulWidget {
  @override
  _DersOzelScreenState createState() => _DersOzelScreenState();
}

class _DersOzelScreenState extends State<DersOzelScreen> {
  List<Konu> _konularVeri;
  String _konuSayisi = '';
  Map<String, dynamic> key;
  bool flag = true;
  String hataMesaji;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (flag) {
      key = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      Future.microtask(() {
        Provider.of<KonuProvider>(context, listen: false)
            .degerleriCek(key['kod'])
            .then((deger) {
          setState(() {
            _konularVeri = deger;
            _konuSayisi = '${_konularVeri.length} Konu';
            flag = false;
          });
        }).catchError((error) {
          setState(() {
            hataMesaji = error;
            _konularVeri = [];
            _konuSayisi = '0 Konu';
            flag = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: dersOzelAppBar(),
      body: buildColumnAnaDers(),
    );
  }

  Column buildColumnAnaDers() {
    return Column(
      children: <Widget>[
        UstAnaKart(
            subtitle: _konuSayisi, title: key['ad'], icon: key['icon'].icon),
        Expanded(
          child: _konularVeri == null
              ? Center(child: CircularProgressIndicator())
              : hataMesaji != null
                  ? Center(child: Text(hataMesaji))
                  : Consumer<KonuProvider>(
                      builder: (_, prov, child) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (ctx, i) {
                            return konuKart(
                                i, _konularVeri[i], key['icon'].icon);
                          },
                          itemCount: _konularVeri.length,
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Card konuKart(int i, Konu ders, IconData icon) {
    final rengiBelirle = ders.durum == false ? Colors.black : DanColor.anaRenk;
    return Card(
      margin: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: i == 10 - 1 ? 15 : 8, //TODO
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
                  .durumuGuncelle(ders.id, key['kod'])
                  .catchError((e) {
                _scaffoldKey.currentState
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              });
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
      elevation: 0,
      centerTitle: true,
      backgroundColor: DanColor.transparan,
    );
  }
}
