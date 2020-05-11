import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../models/firebase_error.dart';
import '../models/user.dart';
import '../screens/login_screen.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _email;
  String _photoUrl;
  String _name;
  LogMethod _method;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signUp(String email, String password) async {}

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token;
  }

  User get user {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return User(
          email: _email,
          name: _name,
          photoUrl: _photoUrl,
          token: _token,
          uid: _userId);
    }
    return User(
        email: 'ekin@abalioglu.com',
        logMethod: LogMethod.Google,
        name: 'Tekrar Giriş Yap',
        photoUrl: 'https://picsum.photos/300/300');
  }

  Future emailleKayitOlYaDaGiris(
      {String email,
      String password,
      AuthMode regOrLog = AuthMode.Login}) async {
    String registerOrLogin =
        regOrLog == AuthMode.Login ? 'signInWithPassword' : 'signUp';
    final apiLink =
        'https://identitytoolkit.googleapis.com/v1/accounts:$registerOrLogin?key=AIzaSyAlyY7R3qk1SsOEN3v1aouYgoHHyKhbP8k';

    final response = await http.post(apiLink,
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final userVeri = jsonDecode(response.body);
    if (userVeri['error'] != null) {
      FirebaseError err = FirebaseError.fromJson(userVeri);
      return err;
    }

    _token = userVeri['idToken'];
    _userId = userVeri['localId'];
    _email = userVeri['email'];
    _photoUrl = 'https://i.ya-webdesign.com/images/empty-avatar-png.png';
    _name = 'Ekin';
    _method = LogMethod.Standart;
    _expiryDate = DateTime.now().add(Duration(minutes: 50));
    notifyListeners();
  }

  Future<void> handleSignInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;

      _token = (await user.getIdToken()).token;
      _userId = user.uid;
      _email = user.email;
      _photoUrl = user.photoUrl;
      _name = user.displayName;
      _method = LogMethod.Google;

      _expiryDate = DateTime.now().add(Duration(minutes: 50));
      notifyListeners();
    } on NoSuchMethodError {
      throw 'Login başarısız. Lütfen tekrar deneyin.';
    } catch (e) {
      throw e.toString();
    }
  }

  void signOutAll() {
    if (_method == LogMethod.Google) {
      _googleSignIn.signOut();
    } else if (_method == LogMethod.Facebook) {
    } else {}
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
