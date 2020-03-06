import 'package:flutter/material.dart';
import 'package:uniapp/screens/grafik_screen.dart';
import './screens/ders_screen.dart';
import './screens/ana_screen.dart';
import './screens/uni_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        DersGenelSecim.dersGenelSecimRoute:(ctx)=>DersGenelSecim(),
        UniScreen.uniScreenRoute:(ctx)=>UniScreen(),
        GrafikScreen.grafikScreenRoute:(ctx)=>GrafikScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Danışman Akademi',
      theme: ThemeData(
        fontFamily: 'Manrope',
        primarySwatch: Colors.deepOrange,
      ),
      home: AnaEkran(),
    );
  }
}
