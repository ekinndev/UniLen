import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../providers/website.dart';
import '../providers/auth.dart';
import '../settings/less_name.dart';
import '../widgets/ders_butonu.dart';
import '../widgets/drawer.dart';
import './ders_ozel_screen.dart';
import '../settings/constants.dart';

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
  static const anaEkranRoute = '/anaekran';
}

class _AnaEkranState extends State<AnaEkran> {
  Future _future;
  FirebaseUser _user;
  final birthday = DateTime(2021, 06, 12);
  @override
  void initState() {
    super.initState();
    _user = Provider.of<Auth>(context, listen: false).user;
    _future = Future.microtask(
        () => Provider.of<Website>(context, listen: false).tarihleriCek());
  }

  @override
  Widget build(BuildContext context) {
    final ekranBoy = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AnaDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'UniLen',
          style: Theme.of(context).appBarTheme.textTheme.headline3,
        ),
      ),
      body: buildColumnAnaSayfa(ekranBoy),
    );
  }

  Column buildColumnAnaSayfa(double ekranBoy) {
    return Column(
      children: <Widget>[
        anaProfilWidget(ekranBoy),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: <Widget>[
              anaDersButonlar(),
              Constants.aralikHeight15,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sınav Sayacı',
                          style: Theme.of(context).textTheme.headline3,
                        )),
                  ),
                  Constants.aralikHeight15,
                  Container(
                    height: ekranBoy * 0.20,
                    width: double.infinity,
                    child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: LinearProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                        return Consumer<Website>(
                            builder: (context, snapshot, __) {
                          Map<String, String> tarihler = snapshot.tarihleriAl;

                          return sinavSayaci(ekranBoy, tarihler['sinavtarih'],
                              tarihler['sinavtarihyazi']);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row sinavSayaci(double ekranBoy, String sinavTarih, String sinavTarihYazi) {
    Widget tarihWidget = Text('Sınav Tarihleri Bulunamadı.');

    if (!(sinavTarih == null || sinavTarihYazi == null)) {
      final dateSinav = DateTime.parse(sinavTarih);
      tarihWidget = Flexible(
        fit: FlexFit.tight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sinavTarihYazi,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(dateSinav.difference(DateTime.now()).inDays.toString() +
                ' Gün Kaldı.')
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Lottie.asset(
          'assets/lottie/timer.json',
          repeat: true,
          alignment: Alignment.centerLeft,
          fit: BoxFit.fill,
          height: 130,
        ),
        tarihWidget,
      ],
    );
  }

  Stack anaProfilWidget(double ekranBoy) {
    return Stack(
      children: <Widget>[
        Container(
          height: ekranBoy * 0.32,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
        ),
        Positioned(
          top: 100,
          left: 15,
          child: profileWidget(),
        ),
      ],
    );
  }

  Column anaDersButonlar() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Hangi Dersin Konusunu Bitirdin ?',
                style: Theme.of(context).textTheme.headline3,
              )),
        ),
        Constants.aralikHeight15,
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            children: <Widget>[
              DersButonu(
                  LessName.tytturkce['icon'],
                  LessName.tytturkce['ad'],
                  LessName.tytturkce['renk'],
                  10,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings:
                                RouteSettings(arguments: LessName.tytturkce)),
                      )),
              DersButonu(
                  LessName.tytmat['icon'],
                  LessName.tytmat['ad'],
                  LessName.tytmat['renk'],
                  10,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings:
                                RouteSettings(arguments: LessName.tytmat)),
                      )),
              DersButonu(
                  LessName.aytmat['icon'],
                  LessName.aytmat['ad'],
                  LessName.tytmat['renk'],
                  10,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings:
                                RouteSettings(arguments: LessName.aytmat)),
                      )),
              DersButonu(
                  LessName.aytfiz['icon'],
                  LessName.aytfiz['ad'],
                  LessName.aytfiz['renk'],
                  10,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings:
                                RouteSettings(arguments: LessName.aytfiz)),
                      )),
              DersButonu(
                  LessName.ayttar1['icon'],
                  LessName.ayttar1['ad'],
                  LessName.ayttar1['renk'],
                  10,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings:
                                RouteSettings(arguments: LessName.ayttar1)),
                      )),
              DersButonu(
                  LessName.aytedeb['icon'],
                  LessName.aytedeb['ad'],
                  LessName.aytedeb['renk'],
                  10,
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DersOzelScreen(),
                            settings:
                                RouteSettings(arguments: LessName.aytedeb)),
                      )),
            ],
          ),
        ),
      ],
    );
  }

  Widget profileWidget() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          minRadius: 25,
          backgroundImage: CachedNetworkImageProvider(
              _user.photoUrl ?? Constants.defaultImg),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  _user.displayName.isEmpty || _user.displayName == null
                      ? "UniLen Öğrenci"
                      : _user.displayName,
                  style: Theme.of(context).textTheme.headline2),
              Text(
                _user.email,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        )
      ],
    );
  }

  // Widget websiteCart(
  //     {String imageUrl, String baslik, String link, bool ilkMi, bool sonMu}) {
  //   final ekranEn = MediaQuery.of(context).size.width;
  //   final ekranBoy = MediaQuery.of(context).size.height;

  //   return InkWell(
  //     onTap: () async {
  //       if (await canLaunch(link)) {
  //         await launch(link);
  //       }
  //     },
  //     child: Container(
  //       width: ekranEn * 0.85 / 1.25,
  //       height: ekranBoy * 0.25,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       margin: EdgeInsets.only(
  //           left: ilkMi ? 8 : 15, bottom: 15, right: sonMu ? 8 : 0),
  //       child: Stack(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(10),
  //             child: CachedNetworkImage(
  //               imageUrl: imageUrl,
  //               fit: BoxFit.fill,
  //               width: ekranEn * 0.85,
  //               height: ekranBoy * 0.25,
  //             ),
  //           ),
  //           Container(
  //             decoration: BoxDecoration(
  //                 color: Colors.black.withOpacity(0.6),
  //                 borderRadius: BorderRadius.circular(10)),
  //             width: ekranEn * 0.85,
  //             height: ekranBoy * 0.3,
  //           ),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: <Widget>[
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     bottom: 10.0, left: 8.0, right: 8.0),
  //                 child: Text(
  //                   baslik,
  //                   textAlign: TextAlign.center,
  //                   style: Theme.of(context).textTheme.headline3.copyWith(
  //                       fontWeight: FontWeight.normal,
  //                       color: Colors.white,
  //                       fontSize: 18),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
