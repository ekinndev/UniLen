import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';

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
    return null;
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
      // print(user.uid);
      // print("signed in " +
      //     user.displayName +
      //     " " +
      //     "access" +
      //     googleAuth.accessToken.toString());

      _token = (await user.getIdToken()).token;
      _userId = user.uid;
      _email = user.email;
      _photoUrl = user.photoUrl;
      _name = user.displayName;
      _method = LogMethod.Google;

      _expiryDate = DateTime.now().add(Duration(minutes: 50));
      notifyListeners();
    } on NoSuchMethodError {
      throw Exception('Login Başarısız Lütfen Tekrar Deneyin.');
    } catch (e) {
      throw e;
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
