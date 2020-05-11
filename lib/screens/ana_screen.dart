import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../settings/colors.dart';
import '../settings/less_name.dart';
import '../widgets/ders_butonu.dart';
import '../widgets/drawer.dart';
import './ders_ozel_screen.dart';

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  bool _flag = true;
  User _user;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_flag) {
      setState(() {
        this._user = Provider.of<Auth>(context, listen: false).user;

        this._flag = false;
      });
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
        actions: <Widget>[
          Icon(Icons.search),
          SizedBox(width: 15),
          Icon(Icons.notifications_none),
          SizedBox(width: 5),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Danışman Akademi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: buildColumnAnaSayfa(ekranBoy, context),
    );
  }

  Column buildColumnAnaSayfa(double ekranBoy, BuildContext context) {
    return Column(
      children: <Widget>[
        anaProfilWidget(ekranBoy),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: <Widget>[
              anaDersButonlar(context),
              SizedBox(height: 15),
              anaSiteYazilar(ekranBoy)
            ],
          ),
        ),
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
            color: DanColor.anaRenk,
          ),
        ),
        Positioned(
          top: 100,
          left: 15,
          child: ProfileWidget(_user),
        ),
      ],
    );
  }
}

Column anaDersButonlar(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Hangi Dersin Konusunu Bitirdin ?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
      ),
      SizedBox(
        height: 15,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
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

Column anaSiteYazilar(double ekranBoy) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sitedeki Son Yazılar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
      ),
      SizedBox(
        height: 15,
      ),
      Container(
        height: ekranBoy * 0.25,
        child: FutureBuilder<List<dynamic>>(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, i) => WebsiteCart(
                  baslik: 'Deneme Test Yazı',
                  imageUrl:
                      'https://danismanakademi.org/wp-content/uploads/2018/03/Hangi-Derse-Nas%C4%B1l-%C3%87al%C4%B1%C5%9Fmal%C4%B1-Felsefe-Grubu.jpg',
                  i: i,
                ),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
              );
            }),
      ),
    ],
  );
}

class ProfileWidget extends StatelessWidget {
  final User _user;
  ProfileWidget(this._user);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          minRadius: 25,
          backgroundImage: NetworkImage(_user.photoUrl),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                _user.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                _user.email,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class WebsiteCart extends StatelessWidget {
  final imageUrl;
  final baslik;
  final link;
  final i;

  const WebsiteCart({this.imageUrl, this.baslik, this.link, this.i});
  @override
  Widget build(BuildContext context) {
    final ekranEn = MediaQuery.of(context).size.width;
    final ekranBoy = MediaQuery.of(context).size.height;

    return Container(
      width: ekranEn * 0.85,
      height: ekranBoy * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          left: i == 0 ? 8 : 15, bottom: 15, right: i == 9 ? 8 : 0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
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
            style: TextStyle(color: Colors.white, fontSize: 20),
          ))
        ],
      ),
    );
  }
}
