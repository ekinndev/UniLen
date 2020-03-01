import 'package:flutter/material.dart';
import './screens/ders_screen.dart';
import './screens/ana_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        DersGenelSecim.dersGenelSecimRoute:(ctx)=>DersGenelSecim(),
       
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Manrope',
        primarySwatch: Colors.deepOrange,
      ),
      home: AnaEkran(),
    );
  }
}
