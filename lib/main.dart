import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/konu.dart';
import './screens/ders_screen.dart';
import './screens/login_screen.dart';
import './screens/uni_screen.dart';
import './screens/universite_detail_screen.dart';
import './screens/ana_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, KonuProvider>(
            create: (_) => KonuProvider(),
            update: (ctx, auth, _) => KonuProvider(auth.user),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) {
            return MaterialApp(
              routes: {
                DersGenelSecim.dersGenelSecimRoute: (ctx) => DersGenelSecim(),
                UniScreen.uniScreenRoute: (ctx) => UniScreen(),
                LoginScreen.authRoute: (ctx) => LoginScreen(),
                UniversiteDetail.universiteDetailRoute: (ctx) =>
                    UniversiteDetail(),
              },
              debugShowCheckedModeBanner: false,
              title: 'Danışman Akademi',
              theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.white70),
                  labelStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                fontFamily: 'Manrope',
                brightness: Brightness.light,
                primarySwatch: Colors.deepOrange,
                accentColor: Color(0xfffe864a),
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  color: Colors.transparent,
                  textTheme: TextTheme(
                    headline3: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                buttonTheme: ButtonThemeData(),
                textTheme: TextTheme(
                  headline1: TextStyle(color: Colors.white, fontSize: 35),
                  headline2: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  headline3: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  headline4: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),

              // home: UniversiteDetail(),
              home: auth.isAuth ? AnaEkran() : LoginScreen(),
              // home: AnaEkran(),
            );
          },
        ));
  }
}
