import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:json_table/json_table_column.dart';
import 'package:http/http.dart' as http;
import '../widgets/ust_uni_ana_kart.dart';

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
  bool _flag = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_flag) {
      Map<String, dynamic> verilenler =
          ModalRoute.of(context).settings.arguments;
      _uniKod = verilenler['kod'];
      _uniAdi = verilenler['uniAdi'];
      _resimId = verilenler['resimId'].toString();
      _flag = false;
      verileriCek().then((veriler) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  Future<void> verileriCek() async {
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
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 15),
                      itemBuilder: (ctx, i) {
                        switch (i) {
                          case 0:
                            return tabloOlustur(
                                context, _say, "SAYISAL BÖLÜMLER");
                            break;
                          case 1:
                            return tabloOlustur(context, _ea, "EA BÖLÜMLER");
                            break;
                          case 2:
                            return tabloOlustur(
                                context, _soz, "SÖZEL BÖLÜMLER");
                            break;
                          case 3:
                            return tabloOlustur(context, _dil, "DİL BÖLÜMLER");
                            break;
                        }
                      },
                      itemCount: 4,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabloOlustur(
      BuildContext context, List<dynamic> liste, String baslik) {
    if (liste == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(baslik),
        tablo(liste, context),
        SizedBox(height: 15),
      ],
    );
  }

  Widget tablo(List<dynamic> json, BuildContext context) {
    if (json == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      margin: EdgeInsets.only(top: 15),
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
                border: Border.all(
                    width: 0.5, color: Colors.grey.withOpacity(0.5))),
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
