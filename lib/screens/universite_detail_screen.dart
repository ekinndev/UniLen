import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/providers/uni.dart';
import 'package:uniapp/settings/constants.dart';

class UniversiteDetail extends StatefulWidget {
  static const universiteDetailRoute = '/unidetail';

  @override
  _UniversiteDetailState createState() => _UniversiteDetailState();
}

class _UniversiteDetailState extends State<UniversiteDetail> {
  String _resimId;
  Map<String, Object> bolumVeriler;
  String _uniAdi;
  bool _flag = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_flag) {
      Map<String, dynamic> verilenler =
          ModalRoute.of(context).settings.arguments;

      _uniAdi = verilenler['uniAdi'];
      _resimId = verilenler['kod'];
      Provider.of<Uni>(context, listen: false).uniyiGetir(verilenler['kod']);
      _flag = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bolumVeriler = Provider.of<Uni>(context).bolumBilgi;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        extendBodyBehindAppBar: true,
        body: buildColumnUniDetailAna(),
      ),
    );
  }

  Column buildColumnUniDetailAna() {
    return Column(
      children: <Widget>[
        UstUniAnaKart(
          subtitle: bolumVeriler != null
              ? '${bolumVeriler['sehir']} - ${bolumVeriler['uniTur']}'
              : '',
          title: _uniAdi ?? "",
          resimId: _resimId,
        ),
        bolumVeriler == null
            ? Expanded(child: Constants.progressIndicator)
            : buildExpandedTablolar(),
      ],
    );
  }

  Expanded buildExpandedTablolar() {
    final List<Widget> bolumler = [
      tabloOlustur(bolumVeriler['say'], "SAYISAL BÖLÜMLER"),
      tabloOlustur(bolumVeriler['ea'], "EA BÖLÜMLER"),
      tabloOlustur(bolumVeriler['söz'], "SÖZEL BÖLÜMLER"),
      tabloOlustur(bolumVeriler['dil'], "DİL BÖLÜMLER")
    ];
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 15),
        itemBuilder: (ctx, i) => bolumler[i],
        itemCount: bolumler.length,
      ),
    );
  }

  Widget tabloOlustur(List<dynamic> liste, String baslik) {
    if (liste == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(baslik, style: Theme.of(context).textTheme.headline3),
        tablo(liste),
        Constants.aralikHeight15,
      ],
    );
  }

  Widget tablo(List<dynamic> json) {
    if (json == null) {
      return Center(child: Constants.progressIndicator);
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
                border: Border.all(width: 0.5), color: Colors.amber),
            child: Text(header,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
          );
        },
        tableCellBuilder: (value) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 0.5, color: Colors.grey.withOpacity(0.5))),
            child: Text(value,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.normal)),
          );
        },
      ),
    );
  }
}

class UstUniAnaKart extends StatelessWidget {
  final String title;
  final String subtitle;
  final String resimId;

  UstUniAnaKart({this.title, this.subtitle, this.resimId});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.32,
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).accentColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Hero(
                tag: "uniLogo$resimId",
                child:
                    Image.asset('assets/logolar/$resimId.png', fit: BoxFit.cover)),
            radius: 55,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Text(subtitle ?? "", style: Theme.of(context).textTheme.headline4),
        ],
      ),
    );
  }
}
