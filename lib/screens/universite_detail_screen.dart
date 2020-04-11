import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:json_table/json_table_column.dart';
import 'package:uniapp/settings/colors.dart';
import 'package:http/http.dart' as http;

class UniversiteDetail extends StatefulWidget {
  static const universiteDetailRoute = '/unidetail';

  @override
  _UniversiteDetailState createState() => _UniversiteDetailState();
}

class _UniversiteDetailState extends State<UniversiteDetail> {
  String _sehir;
  String _uniTur;
  String _resimId;
  List<dynamic> _soz;
  List<dynamic> _say;
  List<dynamic> _dil;
  List<dynamic> _ea;
  String _uniKod;
  String _uniAdi;
  bool flag = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (flag) {
      Map<String, dynamic> verilenler =
          ModalRoute.of(context).settings.arguments;
      _uniKod = verilenler['kod'];
      _uniAdi = verilenler['uniAdi'];
      _resimId = verilenler['resimId'].toString();
      flag = false;
      verileriCek().then((veriler) {
        setState(() {});
      });
    }
  }

  Future<void> verileriCek() async {
    print(_uniKod);
    final jsonData = await http.get(
        'https://danisman-akademi-94376.firebaseio.com/unibolumbilgi/$_uniKod.json');
    final veriler = jsonDecode(jsonData.body);
    _sehir = veriler['sehir'];
    _uniTur = veriler['uniTur'];
    _soz = veriler['söz'];
    _say = veriler['say'];
    _dil = veriler['dil'];
    _ea = veriler['ea'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: <Widget>[
            UstUniAnaKart(
              icon: Icons.ac_unit,
              subtitle: _sehir != null ? '$_sehir - $_uniTur' : '',
              title: _uniAdi ?? "",
              id: _resimId,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(height: 15),
                  Text('SAYISAL BÖLÜMLER'),
                  tablo(_say, context),
                  SizedBox(height: 15),
                  Text('EA BÖLÜMLER'),
                  tablo(_ea, context),
                  SizedBox(height: 15),
                  Text('SÖZEL BÖLÜMLER'),
                  tablo(_soz, context),
                  SizedBox(height: 15),
                  Text('DİL BÖLÜMLER'),
                  tablo(_dil, context),
                  SizedBox(height: 15),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tablo(List<dynamic> json, BuildContext context) {
    if (json == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      margin:EdgeInsets.only(top:15),
      child: JsonTable(
        json,
        columns: [
          JsonTableColumn("bolumAdi", label: "Bölüm Adı"),
          JsonTableColumn("burs", label: "Burs"),
          JsonTableColumn("puan", label: "Puan"),
          JsonTableColumn("siralama", label: "Başarı Sırası"),
        ],
        tableHeaderBuilder: (String header) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5), color: Colors.grey[300]),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display1.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  color: Colors.black87),
            ),
          );
        },
        tableCellBuilder: (value) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            decoration: BoxDecoration(
                border:
                    Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontSize: 14.0, color: Colors.grey[900]),
            ),
          );
        },
      ),
    );
  }
}

class UstUniAnaKart extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String id;

  UstUniAnaKart({this.title, this.subtitle, this.icon, this.id});
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
            child: Hero(
                tag: "uniLogo$id",
                child:
                    Image.asset('assets/logolar/$id.png', fit: BoxFit.cover)),
            radius: 55,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          Text(subtitle ?? "",
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}
