import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/login_screen.dart';

class Auth with ChangeNotifier {
  FirebaseUser _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  FirebaseUser get user {
    return _currentUser;
  }

  void setUser(FirebaseUser newUser) {
    _currentUser = newUser;
    notifyListeners();
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
      _currentUser = userMail;
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
      _currentUser = userGoogle;

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
    _facebookLogin.logOut();
    _currentUser = null;
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
      case 'ERROR_NETWORK_REQUEST_FAILED':
        return "Sunucuya bağlanırken sorun oluştu.";
        break;
      case 'network_error':
        return "Sunucuya bağlanırken sorun oluştu.";
        break;
      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return 'Bu email daha önce başka bir üyelikte kullanılmış.';
        break;
      default:
        return 'Bir hata oluştu. Lütfen daha sonra tekrar deneyin.';
    }
  }

  //Facebook

  Future<void> handleSignInFacebook() async {
    try {
      FacebookLoginResult facebookLoginResult =
          await _facebookLogin.logIn(['email']);

      final accessToken = facebookLoginResult.accessToken.token;
      final facebookAuthCred =
          FacebookAuthProvider.getCredential(accessToken: accessToken);
      final facebookUserData =
          (await _auth.signInWithCredential(facebookAuthCred)).user;
      _currentUser = facebookUserData;
      notifyListeners();
    } on NoSuchMethodError {
      throw 'Login başarısız. Lütfen tekrar deneyin.';
    } on PlatformException catch (f) {
      throw hatayiCevir(f.code);
    } catch (e) {
      throw e.toString();
    }
  }
}
