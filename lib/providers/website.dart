import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Website with ChangeNotifier {
  List _postlar = [];
  final FirebaseUser _user;
  Website([this._user]);

  Map<String, String> _sinavTarih={};
  Future<void> postlariCek() async {
    try {
      if (_postlar.length > 0) {
        return notifyListeners();
      }
      var veriCek = await http.get(
          Uri.encodeFull("https://unilen.org/wp-json/wp/v2/posts?_embed"),
          headers: {"Accept": "application/json"});

      _postlar = jsonDecode(veriCek.body);
      notifyListeners();
    } on SocketException {
      throw 'Sunucuya bağlanırken sorun oluştu.';
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> tarihleriCek() async {
    try {
      if (_user == null || _sinavTarih.isNotEmpty) {
        return notifyListeners();
      }
      final token = (await _user.getIdToken()).token;
      final jsonVeri = jsonDecode(veri.body);
      _sinavTarih = {
        'sinavtarih': jsonVeri['sinavtarih'],
        'sinavtarihyazi': jsonVeri['sinavtarihyazi'],
      };
      notifyListeners();
    } on SocketException {
      throw 'Sunucuya bağlanırken sorun oluştu.';
    } catch (e) {
      throw e.toString();
    }
  }

  List get postlariAl {
    return _postlar;
  }

  Map<String, String> get tarihleriAl {
    if (_user == null) {
      return {
        'sinavtarihyazi': 'Lütfen Tekrar Giriş Yapın',
        'sinavtarih': '3020-10-20'
      };
    }
    return _sinavTarih;
  }
}
