import 'dart:convert';
import 'dart:io';

import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Website with ChangeNotifier {
  List _postlar = [];
  final User _user;
  Website([this._user]);

  Map<String, String> _sinavTarih;
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
      final veri =
          await http.get('https://unilen-75828.firebaseio.com/ayarlar.json?auth=${_user.token}');
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
    return _sinavTarih;
  }
}
