import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _email;
  String _photoUrl;
  String _name;

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
        photoUrl: 'https://i.ya-webdesign.com/images/empty-avatar-png.png');
  }

  Future<bool> signUp({String email, String password}) async {
    try {
      final apiUrl = 'http://192.168.1.34:8080/user/signup';
      final response = await http.put(
        apiUrl,
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );
      final userVeri = jsonDecode(response.body);
      if (!userVeri['error']) {
        return true;
      } else {
        throw userVeri['message'];
      }
    } on SocketException {
      throw "İnternet Bağlantısı Yok.";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> logIn({String email, String password}) async {
    try {
      final apiUrl = 'http://192.168.1.34:8080/user/login';
      final response = await http.post(
        apiUrl,
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );
      final userVeri = jsonDecode(response.body);
      if (userVeri['error']) {
        throw userVeri['message'];
      }
      _token = userVeri['token'];
      _userId = userVeri['userId'];
      _email = userVeri['email'];
      _photoUrl = 'https://i.ya-webdesign.com/images/empty-avatar-png.png';
      _name = 'Öğrenci';
      _expiryDate = DateTime.now().add(Duration(minutes: 50));

      notifyListeners();
    } on SocketException {
      throw "İnternet Bağlantısı Yok.";
    } catch (e) {
      throw e.toString();
    }
  }

  void signOutAll() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
