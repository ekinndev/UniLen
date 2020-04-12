import 'package:flutter/material.dart';
import 'package:uniapp/models/universite.dart';

class UniCard extends StatelessWidget {
  final Universite uni;

  const UniCard({this.uni});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15,left:8,right:8),
      height: MediaQuery.of(context).size.height * 0.37,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
                'https://images.contentful.com/wqz0jxyfamgk/1JQnDmQbZWkGaiCyaG4EkK/b87ee9e9a100d85b06ddbe55bf97a78c/shutterstock_204795163.jpg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.37,
              ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.37,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Hero(
                    tag:"uniLogo${uni.uniId}",
                                    child: Image.asset('assets/logolar/${uni.uniId}.png',
                        fit: BoxFit.cover),
                  ),
                  radius: 40,
                ),
                Text(
                  uni.uniAd,
                  style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  uni.uniMail,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Text(
                  uni.uniAdres,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
             
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
