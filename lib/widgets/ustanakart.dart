import 'package:flutter/material.dart';
import 'package:uniapp/settings/colors.dart';

class UstAnaKart extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  UstAnaKart({this.title, this.subtitle,this.icon});
  @override
  Widget build(BuildContext context) {
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
                title,
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              Text(subtitle,
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
          left: 20,
          bottom: 20,
        ),
        Positioned(
          child: Icon(
            icon,
            size: 100,
            color: Colors.white12,
          ),
          right: 20,
          bottom: 20,
        )
      ],
    );
  }
}
