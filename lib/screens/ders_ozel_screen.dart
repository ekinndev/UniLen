import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../settings/constants.dart';
import '../widgets/ust_ana_kart.dart';
import '../providers/konu.dart';
import '../models/konu.dart';

class DersOzelScreen extends StatefulWidget {
  @override
  _DersOzelScreenState createState() => _DersOzelScreenState();
}

class _DersOzelScreenState extends State<DersOzelScreen> {
  Map<String, dynamic> key;
  bool _flag = true;
  Future<void> _future;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_flag) {
      key = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

      _future = Provider.of<KonuProvider>(context, listen: false)
          .degerleriCek(key['kod']);
      _flag = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: buildColumnAnaDers(),
    );
  }

  Column buildColumnAnaDers() {
    return Column(
      children: <Widget>[
        UstAnaKart(
          subtitle: 'konularında güncel durumun',
          title: key['ad'],
          icon: key['icon'].icon,
          lottie: key['lottie'],
        ),
        Expanded(
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Constants.progressIndicator;
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error));
              }

              return Consumer<KonuProvider>(
                builder: (_, prov, child) {
                  List<Konu> konular = prov.konulariCek;

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, i) {
                      return konuKart(i == 0, konular[i], key['icon'].icon,
                          i == (konular.length - 1));
                    },
                    itemCount: konular.length,
                  );
                },
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
