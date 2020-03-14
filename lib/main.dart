import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/providers/konu.dart';
import './screens/ders_screen.dart';
import './screens/ana_screen.dart';
import './screens/uni_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: KonuProvider()),
      ],
      child: MaterialApp(
        routes: {
          DersGenelSecim.dersGenelSecimRoute: (ctx) => DersGenelSecim(),
          UniScreen.uniScreenRoute: (ctx) => UniScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Danışman Akademi',
        theme: ThemeData(
          fontFamily: 'Manrope',
          primarySwatch: Colors.deepOrange,
        ),
        home: AnaEkran(),
      ),
    );
  }
}
