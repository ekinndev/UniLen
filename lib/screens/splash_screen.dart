import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/customRoute.dart';
import '../providers/auth.dart';
import '../screens/ana_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  final FirebaseUser user;
  SplashScreen([this.user]);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void handleNotification() {
    _firebaseMessaging.configure(onMessage: (not) {
      return launch(not['data']['link']);
    }, onLaunch: (not) {
      return launch(not['data']['link']);
    }, onResume: (not) {
      return launch(not['data']['link']);
    });
  }

  Future<void> serviceCall(BuildContext context) async {
    if (this.widget.user == null) {
      return;
    }

    final prov = Provider.of<Auth>(context, listen: false);

    prov.setUser(widget.user);
    Navigator.of(context)
        .pushAndRemoveUntil(CustomRoute(page: AnaEkran()), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    handleNotification();
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      final prov = Provider.of<Auth>(context, listen: false);
      if (prov.user != null) {
        return Navigator.of(context).pushAndRemoveUntil(
            CustomRoute(page: AnaEkran()), (route) => false);
      } else {
        return serviceCall(context);
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/login/logo.png'),
          LinearProgressIndicator()
        ],
      ),
    );
  }
}
