import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Website with ChangeNotifier {
  List _postlar = [];

  Future<void> postlariCek() async {
    try {
      if (_postlar.length > 0) {
        return notifyListeners();
      }
      var veriCek = await http.get(
          Uri.encodeFull(
              "https://danismanakademi.org/wp-json/wp/v2/posts?_embed"),
          headers: {"Accept": "application/json"});

      _postlar = jsonDecode(veriCek.body);
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
}
