import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
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
  final FirebaseUser user;
  AnaEkran([this.user]);
}

class _AnaEkranState extends State<AnaEkran> {
  bool _flag = true;
  User _user;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final prov = Provider.of<Auth>(context, listen: false);
    if (_flag) {
      if (widget.user != null) {
        widget.user.getIdToken().then((data) {
          setState(() {
            this._user = User(
                email: widget.user.email,
                name: widget.user.displayName.isEmpty
                    ? 'Danışman Akademi Öğrenci'
                    : widget.user.displayName,
                photoUrl: widget.user.photoUrl ??
                    'https://i.ya-webdesign.com/images/empty-avatar-png.png',
                token: data.token,
                uid: widget.user.uid);

            this._flag = false;
            prov.setUser(this._user);
          });
        });
      } else {
        setState(() {
          this._user = prov.user;

          this._flag = false;
        });
      }
    }
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
          'Danışman Akademi',
          style: Theme.of(context).appBarTheme.textTheme.headline3,
        ),
      ),
      body: buildColumnAnaSayfa(ekranBoy, context),
    );
  }

  Column buildColumnAnaSayfa(double ekranBoy, BuildContext context) {
    return Column(
      children: <Widget>[
        anaProfilWidget(ekranBoy, context),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: <Widget>[
              anaDersButonlar(context),
              Constants.aralikHeight15,
              anaSiteYazilar(ekranBoy, context)
            ],
          ),
        ),
      ],
    );
  }

  Stack anaProfilWidget(double ekranBoy, BuildContext context) {
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
          child: _user == null
              ? Constants.progressIndicator
              : profileWidget(_user, context),
        ),
      ],
    );
  }
}

Column anaDersButonlar(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Hangi Dersin Konusunu Bitirdin ?',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.black),
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
                          settings: RouteSettings(arguments: LessName.tytmat)),
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
                          settings: RouteSettings(arguments: LessName.aytmat)),
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
                          settings: RouteSettings(arguments: LessName.aytfiz)),
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
                          settings: RouteSettings(arguments: LessName.ayttar1)),
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
                          settings: RouteSettings(arguments: LessName.aytedeb)),
                    )),
          ],
        ),
      ),
    ],
  );
}

Column anaSiteYazilar(double ekranBoy, BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sitedeki Son Yazılar',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.black),
            )),
      ),
      Constants.aralikHeight15,
      Container(
        height: ekranBoy * 0.25,
        child: FutureBuilder<List<dynamic>>(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Constants.progressIndicator);
              }
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) => websiteCart(
                    baslik: 'Deneme Test Yazı',
                    imageUrl:
                        'https://danismanakademi.org/wp-content/uploads/2018/03/Hangi-Derse-Nas%C4%B1l-%C3%87al%C4%B1%C5%9Fmal%C4%B1-Felsefe-Grubu.jpg',
                    i: i,
                    context: context),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
              );
            }),
      ),
    ],
  );
}

Widget profileWidget(User _user, BuildContext context) {
  return Row(
    children: <Widget>[
      CircleAvatar(
        minRadius: 25,
        backgroundImage: CachedNetworkImageProvider(_user.photoUrl),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_user.name, style: Theme.of(context).textTheme.headline2),
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

Widget websiteCart(
    {String imageUrl,
    String baslik,
    String link,
    int i,
    BuildContext context}) {
  final ekranEn = MediaQuery.of(context).size.width;
  final ekranBoy = MediaQuery.of(context).size.height;

  return Container(
    width: ekranEn * 0.85,
    height: ekranBoy * 0.25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.only(
        left: i == 0 ? 8 : 15, bottom: 15, right: i == 9 ? 8 : 0), //TODO
    child: Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            width: ekranEn * 0.85,
            height: ekranBoy * 0.25,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10)),
          width: ekranEn * 0.85,
          height: ekranBoy * 0.3,
        ),
        Center(
          child: Text(
            baslik,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Image.asset(
            'assets/login/logotek.png',
            width: 60,
          ),
        )
      ],
    ),
  );
}
