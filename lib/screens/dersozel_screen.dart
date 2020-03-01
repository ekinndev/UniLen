import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniapp/settings/colors.dart';
import 'package:uniapp/settings/icons.dart';

class DersOzelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: dersOzelAppBar(),
      body: Column(
        children: <Widget>[
          ustKart(context),
          konularListView(),
        ],
      ),
    );
  }

  Stack ustKart(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.32,
          width: double.infinity,
          decoration: BoxDecoration(
            color: DanColor.anaRenk,
          ),
        ),
        Positioned(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'TYT Fizik',
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              Text('10 Konu',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
          left: 20,
          bottom: 20,
        ),
        Positioned(
          child: Icon(
            DanIcons.fizikIcon.icon,
            size: 100,
            color: Colors.white12,
          ),
          right: 20,
          bottom: 20,
        )
      ],
    );
  }

  Expanded konularListView() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (ctx, i) {
          return konuKart(i);
        },
        itemCount: 10,
      ),
    );
  }

  Card konuKart(int i) {
    return Card(
      margin: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: i == 10 - 1 ? 15 : 8,
          top: i == 0 ? 15 : 8),
      child: ListTile(
        leading: Icon(
          DanIcons.fizikIcon.icon,
          color: i%2==0 ? Colors.black:DanColor.anaRenk,
          size: 35,
        ),
        title: Text(
          'Atom Fiziğine Giriş',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: i%2==0 ? Colors.black:DanColor.anaRenk, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(SimpleLineIcons.check, color: i%2==0 ? Colors.black:DanColor.anaRenk)),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
         side:i%2==0 ?BorderSide(): BorderSide(color:  DanColor.anaRenk)),
    );
  }

  AppBar dersOzelAppBar() {
    return AppBar(
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
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }
}
