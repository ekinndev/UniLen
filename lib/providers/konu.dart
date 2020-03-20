import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uniapp/models/konu.dart';

class KonuProvider with ChangeNotifier {
  final String apiLink = 'https://danisman-akademi-94376.firebaseio.com/';

  Future<List<Konu>> degerleriCek(String kod) async {
    final konuApiLink = '${apiLink}konular/$kod.json';
    print(konuApiLink);
    final konuJson = await http.get(konuApiLink);
    final List<dynamic> jsonKonuJson = jsonDecode(konuJson.body);
    final List<Konu> donusturulmusVeri =
        jsonKonuJson.map((konu) => Konu(konu['id'], konu['konu'])).toList();
    
    return donusturulmusVeri;
  }

  void durumuGuncelle(int index) {
    // if (_degerler[index]['durum'] != null) {
    //   _degerler[index]['durum'] = !_degerler[index]['durum'];
    // } else {
    //   _degerler[index]['durum'] = true;
    // }
    // notifyListeners();
  }
}
