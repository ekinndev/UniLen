import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';
import '../screens/login_screen.dart';

class Auth with ChangeNotifier {
  User _currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get token {
    return _currentUser.token;
  }

  User get user {
    return _currentUser;
  }

  void setUser(User newUser) {
    _currentUser = newUser;
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
      final _token = (await userMail.getIdToken()).token;
      final _userId = userMail.uid;
      final _email = userMail.email;
      final _photoUrl =
          "https://i.ya-webdesign.com/images/empty-avatar-png.png";
      final _name = "Danışman Akademi Öğrenci";
      _currentUser = User(
          email: _email,
          name: _name,
          photoUrl: _photoUrl,
          token: _token,
          uid: _userId);
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

      final _token = (await userGoogle.getIdToken()).token;
      final _userId = userGoogle.uid;
      final _email = userGoogle.email;
      final _photoUrl = userGoogle.photoUrl;
      final _name = userGoogle.displayName;
      _currentUser = User(
          email: _email,
          name: _name,
          photoUrl: _photoUrl,
          token: _token,
          uid: _userId);
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

    _currentUser = null;
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
