import 'package:flutter/material.dart';

class WebsiteCart extends StatelessWidget {
  final imageUrl;
  final baslik;
  final link;
  final i;

  const WebsiteCart({this.imageUrl, this.baslik, this.link, this.i});
  @override
  Widget build(BuildContext context) {
    final ekranEn = MediaQuery.of(context).size.width;
    final ekranBoy = MediaQuery.of(context).size.height;

    return Container(
      width: ekranEn * 0.85,
      height: ekranBoy * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          left: i == 0 ? 8 : 15, bottom: 15, right: i == 9 ? 8 : 0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
              width: ekranEn * 0.85,
              height: ekranBoy * 0.25,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)),
            width: ekranEn * 0.85,
            height: ekranBoy * 0.3,
          ),
          Center(
              child: Text(
            baslik,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ))
        ],
      ),
    );
  }
}
