import 'package:flutter/material.dart';


class DersButonu extends StatelessWidget {
  final Icon icon;
  final String text;
  final Color renk;
  final double radius;
  final Function btnHandler;
  DersButonu(this.icon, this.text, this.renk, this.radius,[this.btnHandler]);
  @override
  Widget build(
    BuildContext context,
  ) {
    return RawMaterialButton(
      onPressed:btnHandler??(){},
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.radius)),
      splashColor: Colors.deepOrange,
      fillColor: renk,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.46, maxHeight: 70),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              minRadius: 25,
              child: icon,
              backgroundColor: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
