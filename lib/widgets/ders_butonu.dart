import 'package:flutter/material.dart';

class DersButonu extends StatelessWidget {
  final Icon _icon;
  final String _text;
  final Color _renk;
  final double _radius;
  final Function _btnHandler;
  DersButonu(this._icon, this._text, this._renk, this._radius,
      [this._btnHandler]);
  @override
  Widget build(
    BuildContext context,
  ) {
    return RawMaterialButton(
      onPressed: _btnHandler ?? () {},
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this._radius)),
      splashColor: Colors.deepOrange,
      fillColor: _renk,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.46, maxHeight: 70),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              minRadius: 25,
              child: _icon,
              backgroundColor: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                _text,
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
