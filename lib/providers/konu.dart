import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uniapp/models/konu.dart';

class KonuProvider with ChangeNotifier {
  final String _apiLink = 'https://danisman-akademi-94376.firebaseio.com/';

  List<Konu> _konuVeriler = [];

  Future<List<Konu>> degerleriCek(String kod) async {
    final konuApiLink = '${_apiLink}konular/$kod';
    final konuJson = await http.get('$konuApiLink.json');
    final List<dynamic> jsonKonuJson = jsonDecode(konuJson.body);
    final List<Konu> donusturulmusVeri =
        jsonKonuJson.map((konu) => Konu(konu['id'], konu['konu'])).toList();
    _konuVeriler = donusturulmusVeri;
    return _konuVeriler;
  }

  List<Konu> get konulariCek {
    return _konuVeriler;
  }

  void durumuGuncelle(String id) {
    final konuIndex = _konuVeriler.indexWhere((konu) {
      return konu.id == id;
    });
    _konuVeriler[konuIndex].durum = !_konuVeriler[konuIndex].durum;
    notifyListeners();
  }
}
