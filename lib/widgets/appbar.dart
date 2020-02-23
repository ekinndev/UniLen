import 'package:flutter/material.dart';

class AnaAppBar {
  static Widget getAppBar() {
    return AppBar(
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
      ),
    );
  }
}
