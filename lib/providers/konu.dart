import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uniapp/models/konu.dart';
import '../models/user.dart';

class KonuProvider with ChangeNotifier {
  final User _user;
  KonuProvider([this._user]);

  List<Konu> _konuVeriler = [];
 

  Future<List<Konu>> degerleriCek(String kod) async {
    try {
      final konuApiLink = 'http://192.168.1.34:8080/ders/$kod';

      final konuJson = await http.get(konuApiLink);
      final konuDurumJson = await http
          .get('http://192.168.1.34:8080/user/dersler?auth=${_user.token}');
      final konuDurumVeri = jsonDecode(konuDurumJson.body);
      final Map<String, dynamic> jsonKonuJson = jsonDecode(konuJson.body)[0];
      final List<dynamic> dersVeri = jsonKonuJson['konular'];
      final List<Konu> donusturulmusVeri = dersVeri.map((konu) {
        return Konu(
            konu['id'],
            konu['konu'],
            konuDurumVeri[konu['id']] == null
                ? false
                : konuDurumVeri[konu['id']]);
      }).toList();

      _konuVeriler = donusturulmusVeri;
      return konulariCek;
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
      final konuIndex = _konuVeriler.indexWhere((konu) {
        return konu.id == id;
      });
      final dersDurum = _konuVeriler[konuIndex].durum;
      _konuVeriler[konuIndex].durum = !dersDurum;

      notifyListeners();
      final link =
          'http://192.168.1.34:8080/user/dersguncelle/?auth=${_user.token}&durum=${_konuVeriler[konuIndex].durum.toString()}&id=$id';
      final response = await http.patch(link);
      print(response.body);
    } on SocketException {
      throw "İnternet bağlantısı ya da veri yok.";
    } catch (e) {
      throw e.toString();
    }
  }
}
