import 'package:flutter/material.dart';

class UniCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      height: MediaQuery.of(context).size.height * 0.36,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://www.gercekgundem.com/images/posts/201809/88b7df178ff775ad_480x270.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.36,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.36,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ege Üniversitesi',
                  style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  
                ),
                Text(
                  'webadmin@ege.edu.tr',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Ege Üniversitesi Rektörlüğü Gençlik Caddesi No:12 PK.35040 Bornova / İzmir',
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_Ege_Uni.png'),
                radius: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
