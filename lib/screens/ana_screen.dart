import 'package:flutter/material.dart';
import '../settings/icons.dart';
import '../widgets/dersbutonu.dart';
import '../settings/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/profilewidget.dart';

class AnaEkran extends StatelessWidget {
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
    final ekranEn = MediaQuery.of(context).size.width;
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
              child: ProfileWidget(),
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
                        DanIcons.fizikIcon, 'Fizik', DanColor.fizikRenk, 10),
                    DersButonu(
                        DanIcons.matIcon, 'Matematik', DanColor.matRenk, 10),
                    DersButonu(
                        DanIcons.bioIcon, 'Biyoloji', DanColor.bioRenk, 10),
                    DersButonu(DanIcons.kimIcon, 'Kimya', DanColor.kimRenk, 10),
                    DersButonu(
                        DanIcons.tarihIcon, 'Tarih', DanColor.tarihRenk, 10),
                    DersButonu(
                        DanIcons.turkceIcon, 'Türkçe', DanColor.edebRenk, 10),
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
                height: ekranBoy * 0.3,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                        left: i == 0 ? 8 : 15,
                        bottom: 15,
                        right: i == 9 ? 8 : 0),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://danismanakademi.org/wp-content/uploads/2020/03/2020yksprovalari21-01.03.2020.png',
                            fit: BoxFit.fill,
                            width: ekranEn * 0.85,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10)),
                            width: ekranEn * 0.85),
                        Center(
                            child: Text(
                          'YKS DENEMESİ (01.03.2020)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))
                      ],
                    ),
                    width: ekranEn * 0.85,
                  ),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
