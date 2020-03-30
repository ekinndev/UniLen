import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/models/user.dart';
import 'package:uniapp/widgets/websitecard.dart';
import '../widgets/dersbutonu.dart';
import '../settings/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/profilewidget.dart';
import '../settings/lessname.dart';
import 'dersozel_screen.dart';
import '../providers/auth.dart';

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  bool flag = true;
  User user;
  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    if (flag) {
      setState(() {
        this.user = Provider.of<Auth>(context, listen: false).user;

        this.flag = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AnaDrawer(),
      appBar: AppBar(
        centerTitle: true,
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
        backgroundColor: Colors.transparent,
        title: Text(
          'Danışman Akademi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: anaKolon(context),
    );
  }

  Column anaKolon(BuildContext context) {
    final ekranBoy = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Stack(
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
              child: ProfileWidget(user),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Hangi Dersin Konusunu Bitirdin ?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                                  settings: RouteSettings(
                                      arguments: LessName.tytturkce)),
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
                                  settings: RouteSettings(
                                      arguments: LessName.tytmat)),
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
                                  settings: RouteSettings(
                                      arguments: LessName.aytmat)),
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
                                  settings: RouteSettings(
                                      arguments: LessName.aytfiz)),
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
                                  settings: RouteSettings(
                                      arguments: LessName.ayttar1)),
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
                                  settings: RouteSettings(
                                      arguments: LessName.aytedeb)),
                            )),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sitedeki Son Yazılar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
