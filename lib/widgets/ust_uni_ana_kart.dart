import 'package:flutter/material.dart';
import '../settings/colors.dart';
class UstUniAnaKart extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String id;

  UstUniAnaKart({this.title, this.subtitle, this.icon, this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.32,
      width: double.infinity,
      decoration: BoxDecoration(
        color: DanColor.anaRenk,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Hero(
                tag: "uniLogo$id",
                child:
                    Image.asset('assets/logolar/$id.png', fit: BoxFit.cover)),
            radius: 55,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          Text(subtitle ?? "",
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}