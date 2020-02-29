import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniapp/widgets/dersbutonu.dart';
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
        'Danışman Akademi',style: TextStyle(fontWeight: FontWeight.bold),
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
              height: ekranBoy * 0.34,
              width: double.infinity,
              decoration: BoxDecoration(
                color: DanColor.felseDinRenk,
              ),
            ),
            Positioned(
              top: 100,
              left: 15,
              child: ProfileWidget(),
            ),
            Positioned(
              bottom: 10,
              right: 5,
              child: graphButton(),
            )
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
                        Icon(
                          FontAwesome5Solid.atom,
                          color: DanColor.fizikRenk,
                          size: 35,
                        ),
                        'Fizik',
                        DanColor.fizikRenk,10),
                    DersButonu(
                        Icon(
                          MaterialCommunityIcons.calculator_variant,
                          color: DanColor.matRenk,
                          size: 35,
                        ),
                        'Matematik',
                        DanColor.matRenk,10),
                    DersButonu(
                        Icon(
                          MaterialCommunityIcons.microscope,
                          color: DanColor.bioRenk,
                          size: 35,
                        ),
                        'Biyoloji',
                        DanColor.bioRenk,10),
                    DersButonu(
                        Icon(
                          Fontisto.test_tube,
                          color: DanColor.kimRenk,
                          size: 35,
                        ),
                        'Kimya',
                        DanColor.kimRenk,10),
                    DersButonu(
                        Icon(
                          SimpleLineIcons.book_open,
                          color: DanColor.tarihRenk,
                          size: 35,
                        ),
                        'Türkçe',
                        DanColor.tarihRenk,10),
                    DersButonu(
                        Icon(
                          MaterialCommunityIcons.thought_bubble_outline,
                          color: DanColor.edebRenk,
                          size: 35,
                        ),
                        'Din Felsefe',
                        DanColor.edebRenk,10),
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
                      'Popüler Üniversiteler',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: ekranBoy * 0.25,
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
                            'https://www.kanalben.com/images/resize/100/656x400/haberler/2018/10/izmir_ekonomi_universitesi_nde_deprem_o_isimden_flas_istifa_h504033_e30b1.jpg',
                            fit: BoxFit.fill,
                            width: ekranEn * 0.85,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            width: ekranEn * 0.85),
                        Center(
                            child: Text(
                          'Ege Üniversitesi',
                          style: TextStyle(color: Colors.white, fontSize: 25),
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

  ClipOval graphButton() {
    return ClipOval(
      child: Material(
        color: Colors.white, // button color
        child: InkWell(
          splashColor: Colors.transparent,
          // inkwell color
          child: SizedBox(
              width: 56,
              height: 56,
              child:
                  Icon(AntDesign.linechart, size: 30, color: DanColor.felseDinRenk)),
          onTap: () {},
        ),
      ),
    );
  }
}
