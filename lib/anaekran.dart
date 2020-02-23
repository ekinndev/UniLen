import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniapp/widgets/dersbutonu.dart';
import './colors.dart';
import './widgets/appbar.dart';
import './widgets/drawer.dart';

class AnaEkran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AnaDrawer(),
      appBar: AnaAppBar.getAppBar(),
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
                gradient: LinearGradient(
                  colors: [DanColor.felseDinRenk, DanColor.cogRenk],
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 15,
              child: profilePart(),
            ),
            Positioned(
              bottom: 10,
              right: 5,
              child: graphButton(),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView(
      
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
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
                padding: const EdgeInsets.only(left:8.0),
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
                        DanColor.fizikRenk),
                    DersButonu(
                        Icon(
                          MaterialCommunityIcons.calculator_variant,
                          color: DanColor.matRenk,
                          size: 35,
                        ),
                        'Matematik',
                        DanColor.matRenk),
                    DersButonu(
                        Icon(
                          MaterialCommunityIcons.microscope,
                          color: DanColor.bioRenk,
                          size: 35,
                        ),
                        'Biyoloji',
                        DanColor.bioRenk),
                    DersButonu(
                        Icon(
                          Fontisto.test_tube,
                          color: DanColor.kimRenk,
                          size: 35,
                        ),
                        'Kimya',
                        DanColor.kimRenk),
                    DersButonu(
                        Icon(
                          SimpleLineIcons.book_open,
                          color: DanColor.tarihRenk,
                          size: 35,
                        ),
                        'Türkçe',
                        DanColor.tarihRenk),
                    DersButonu(
                        Icon(
                          MaterialCommunityIcons.thought_bubble_outline,
                          color: DanColor.edebRenk,
                          size: 35,
                        ),
                        'Din Felsefe',
                        DanColor.edebRenk),
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
              SizedBox(
                height: ekranBoy*0.25,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) => Container(
                    margin: EdgeInsets.only(left: 8, bottom: 15),
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
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row profilePart() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          minRadius: 25,
          backgroundImage:
              NetworkImage('https://ekinabalioglu.com/resimler/ekin.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                'Ekin Abalıoğlu',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'SAY/12. Sınıf',
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
              child: Icon(
                AntDesign.linechart,
                size: 30,
                color: Color(0xFFfe864a),
              )),
          onTap: () {},
        ),
      ),
    );
  }
}
