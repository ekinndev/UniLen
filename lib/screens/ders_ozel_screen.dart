import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/settings/constants.dart';
import '../widgets/ust_ana_kart.dart';
import '../providers/konu.dart';
import '../models/konu.dart';

class DersOzelScreen extends StatefulWidget {
  @override
  _DersOzelScreenState createState() => _DersOzelScreenState();
}

class _DersOzelScreenState extends State<DersOzelScreen> {
  Map<String, dynamic> key;
  bool flag = true;
  String hataMesaji;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Konu> _konularVeri = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (flag) {
      key = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

      Provider.of<KonuProvider>(context, listen: false)
          .degerleriCek(key['kod'])
          .catchError((e) {
        setState(() {
          hataMesaji = e;
          _konularVeri = [];

          flag = false;
        });
      });
      flag = false;
      // .then((deger) {
    }
  }

  @override
  void dispose() {
    super.dispose();
    hataMesaji = null;
  }

  @override
  Widget build(BuildContext context) {
    _konularVeri = Provider.of<KonuProvider>(context).konulariCek;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: buildColumnAnaDers(_konularVeri),
    );
  }

  Column buildColumnAnaDers(List<Konu> konular) {
    return Column(
      children: <Widget>[
        UstAnaKart(
          subtitle: '${konular.length} konu var.',
          title: key['ad'],
          icon: key['icon'].icon,
          lottie: key['lottie'],
        ),
        Expanded(
          child: hataMesaji != null
              ? Center(child: Text(hataMesaji))
              : konular.isEmpty
                  ? Center(child: Constants.progressIndicator)
                  : Consumer<KonuProvider>(
                      builder: (_, prov, child) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (ctx, i) {
                            return konuKart(i == 0, konular[i],
                                key['icon'].icon, i == (konular.length - 1));
                          },
                          itemCount: konular.length,
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Card konuKart(bool ilkMi, Konu ders, IconData icon, bool sonMu) {
    final rengiBelirle =
        ders.durum == false ? Colors.black : Theme.of(context).accentColor;
    return Card(
      margin: EdgeInsets.only(
          left: 8, right: 8, bottom: sonMu ? 15 : 8, top: ilkMi ? 15 : 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: rengiBelirle,
          size: 35,
        ),
        title: Text(
          ders.konu,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: rengiBelirle),
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
}
