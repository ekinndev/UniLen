import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/customRoute.dart';
import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/ana_screen.dart';

class SplashScreen extends StatelessWidget {
  final FirebaseUser user;
  SplashScreen([this.user]);

  Future<void> serviceCall(BuildContext context) async {
    if (this.user == null) {
      return;
    }

    final prov = Provider.of<Auth>(context, listen: false);

    final data = await this.user.getIdToken();

    User _user = User(
        email: this.user.email,
        name: this.user.displayName ?? 'Danışman Akademi Öğrenci',
        photoUrl: this.user.photoUrl ??
            'https://i.ya-webdesign.com/images/empty-avatar-png.png',
        token: data.token,
        uid: this.user.uid);

    prov.setUser(_user);
    Navigator.of(context)
        .pushAndRemoveUntil(CustomRoute(page: AnaEkran()), (route) => false);
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
      body: Center(child: Text('Splash Screen')),
    );
  }
}
