import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/konu.dart';
import '../settings/constants.dart';

class KonuProvider with ChangeNotifier {
  final FirebaseUser _user;
  KonuProvider([this._user]);

  List<Konu> _konuVeriler = [];

  Future<void> degerleriCek(String kod) async {
    try {
      final token = (await _user.getIdToken()).token;
      _konuVeriler = [];
      final konuApiLink = '${Constants.apiLink}konular/$kod';
      final durumApiLink =
          '${Constants.apiLink}konulardurum/${_user.uid}/$kod.json?auth=$token';
      final durumJson = await http.get(durumApiLink);
      final konuJson = await http.get('$konuApiLink.json?auth=$token');
      final jsonDurumJson = jsonDecode(durumJson.body);

      final List<dynamic> jsonKonuJson = jsonDecode(konuJson.body);
      final List<Konu> donusturulmusVeri = jsonKonuJson
          .map(
            (konu) => Konu(
              konu['id'],
              konu['konu'],
              jsonDurumJson == null ? 0 : jsonDurumJson[konu['id']] ?? 0,
            ),
          )
          .toList();
      _konuVeriler = donusturulmusVeri;
      notifyListeners();
    } on SocketException {
      throw "Sunucuya bağlanırken sorun oluştu.";
    } catch (e) {
      throw e.toString();
    }
  }

  List<Konu> get konulariCek {
    return _konuVeriler;
  }

  Future<void> yildiziArtir(String id, String kod) async {
    try {
      final token = (await _user.getIdToken()).token;
      final link =
          '${Constants.apiLink}konulardurum/${_user.uid}/$kod/$id.json?auth=$token';
      final konuIndex = _konuVeriler.indexWhere((konu) {
        return konu.id == id;
      });
      if (_konuVeriler[konuIndex].yildiz == 5) {
        _konuVeriler[konuIndex].yildiz = 0;
      } else {
        _konuVeriler[konuIndex].yildiz += 1;
      }

      notifyListeners();
      await http.put(link, body: jsonEncode(_konuVeriler[konuIndex].yildiz));
    } on SocketException {
      throw "Sunucuya bağlanırken sorun oluştu.";
    } catch (e) {
      throw e.toString();
    }
  }
}
