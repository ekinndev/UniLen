import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/konu.dart';
import './screens/ders_screen.dart';
import './screens/login_screen.dart';
import './screens/uni_screen.dart';
import './screens/universite_detail_screen.dart';

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
                UniversiteDetail.universiteDetailRoute:(ctx)=>UniversiteDetail(),
              },
              debugShowCheckedModeBanner: false,
              title: 'Danışman Akademi',
              theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(),
                fontFamily: 'Manrope',
                primarySwatch: Colors.deepOrange,
              ),
              home: UniversiteDetail(),
              // home: auth.isAuth ? AnaEkran() : LoginScreen(),
            );
          },
        ));
  }
}
