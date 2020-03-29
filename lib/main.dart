import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/providers/konu.dart';
import 'package:uniapp/screens/ana_screen.dart';
import './screens/ders_screen.dart';
import './screens/uni_screen.dart';
import './screens/login_screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: KonuProvider()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) {
            return MaterialApp(
              routes: {
                DersGenelSecim.dersGenelSecimRoute: (ctx) => DersGenelSecim(),
                UniScreen.uniScreenRoute: (ctx) => UniScreen(),
                LoginScreen.authRoute: (ctx) => LoginScreen(),
              },
              debugShowCheckedModeBanner: false,
              title: 'Danışman Akademi',
              theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(),
                fontFamily: 'Manrope',
                primarySwatch: Colors.deepOrange,
              ),
              home: auth.isAuth ? AnaEkran() : LoginScreen(),
            );
          },
        ));
  }
}
