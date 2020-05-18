import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uniapp/models/konu.dart';
import '../models/user.dart';

class KonuProvider with ChangeNotifier {
  final User _user;
  KonuProvider([this._user]);
  final String _apiLink = 'https://danisman-akademi-94376.firebaseio.com/';

  List<Konu> _konuVeriler = [];

  Future<void> degerleriCek(String kod) async {
    try {
      _konuVeriler = [];
      final konuApiLink = '${_apiLink}konular/$kod';
      final durumApiLink =
          '${_apiLink}konulardurum/${_user.uid}/$kod.json?auth=${_user.token}';
      final durumJson = await http.get(durumApiLink);
      final konuJson = await http.get('$konuApiLink.json?auth=${_user.token}');
      final jsonDurumJson = jsonDecode(durumJson.body);

      final List<dynamic> jsonKonuJson = jsonDecode(konuJson.body);
      final List<Konu> donusturulmusVeri = jsonKonuJson
          .map((konu) => Konu(
              konu['id'],
              konu['konu'],
              jsonDurumJson == null
                  ? false
                  : jsonDurumJson[konu['id']] ?? false))
          .toList();
      _konuVeriler = donusturulmusVeri;
      notifyListeners();
    } on SocketException {
      throw "İnternet bağlantısı ya da veri yok.";
    } catch (e) {
      throw e.toString();
    }
  }

  List<Konu> get konulariCek {
    return _konuVeriler;
  }


  Future<void> durumuGuncelle(String id, String kod) async {
    try {
      final link =
          '${_apiLink}konulardurum/${_user.uid}/$kod/$id.json?auth=${_user.token}';
      final konuIndex = _konuVeriler.indexWhere((konu) {
        return konu.id == id;
      });
      final dersDurum = _konuVeriler[konuIndex].durum;
      _konuVeriler[konuIndex].durum = !dersDurum;

      notifyListeners();
      await http.put(link, body: jsonEncode(!dersDurum));
    } on SocketException {
      throw "İnternet bağlantısı ya da veri yok.";
    } catch (e) {
      throw e.toString();
    }
  }
}
