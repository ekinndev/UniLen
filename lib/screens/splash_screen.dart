import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/models/user.dart';
import 'package:uniapp/providers/auth.dart';
import 'package:uniapp/screens/ana_screen.dart';

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
    Navigator.of(context).pushReplacementNamed(AnaEkran.anaEkranRoute);
  }

  @override
  Widget build(BuildContext context) {
    serviceCall(context);
    return Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}
