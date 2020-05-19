import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';
import '../screens/login_screen.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  String _email;
  String _photoUrl;
  String _name;
  User currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get token {
    return _token;
  }

  User get user {
    if (_token != null && currentUser == null) {
      currentUser = User(
          email: _email,
          name: _name,
          photoUrl: _photoUrl,
          token: _token,
          uid: _userId);
    }
    return currentUser;
  }

  void setUser(User newUser) {
    _token = newUser.token;
    _userId = newUser.uid;
    _email = newUser.email;
    _photoUrl = newUser.photoUrl;
    _name = newUser.name;

    currentUser = newUser;
  }

  Future<void> emailLoginOrSignUp(
      {String email,
      String password,
      AuthMode regOrLog = AuthMode.Login}) async {
    try {
      AuthResult result;
      if (regOrLog == AuthMode.SignUp) {
        result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      final FirebaseUser userMail = result.user;
      _token = (await userMail.getIdToken()).token;
      _userId = userMail.uid;
      _email = userMail.email;
      _photoUrl = "https://i.ya-webdesign.com/images/empty-avatar-png.png";
      _name = "Danışman Akademi Öğrenci";
      notifyListeners();
    } on NoSuchMethodError {
      throw 'Login başarısız. Lütfen tekrar deneyin.';
    } on PlatformException catch (f) {
      throw hatayiCevir(f.code);
    } catch (e) {
      throw e.toString();
    }
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
      final FirebaseUser userGoogle =
          (await _auth.signInWithCredential(credential)).user;

      _token = (await userGoogle.getIdToken()).token;
      _userId = userGoogle.uid;
      _email = userGoogle.email;
      _photoUrl = userGoogle.photoUrl;
      _name = userGoogle.displayName;
      notifyListeners();
    } on NoSuchMethodError {
      throw 'Login başarısız. Lütfen tekrar deneyin.';
    } on PlatformException catch (f) {
      throw hatayiCevir(f.code);
    } catch (e) {
      throw e.toString();
    }
  }

  void signOutAll() {
    _auth.signOut();
    _googleSignIn.signOut();
    _token = null;
    _userId = null;
    _email = null;
    _photoUrl = null;
    _name = null;
    notifyListeners();
  }

  String hatayiCevir(String hata) {
    switch (hata) {
      case 'ERROR_USER_NOT_FOUND':
        return 'Email ya da şifre yanlış.';
        break;

      case 'ERROR_WRONG_PASSWORD':
        return 'Email ya da şifre yanlış.';
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'Bu email kullanılmaktadır.';
        break;
      default:
        return 'Bir hata oluştu. Lütfen daha sonra tekrar deneyin.';
    }
  }
}
