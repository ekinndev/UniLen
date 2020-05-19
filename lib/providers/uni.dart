import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uniapp/models/universite.dart';
import 'package:http/http.dart' as http;
import 'package:uniapp/models/user.dart';

class Uni with ChangeNotifier {
  final User user;
  Uni([this.user]);
  int _sayfa = 1;
  List<Universite> _uniler = [];
  List<Universite> _searchUniler = [];

  Future<void> universiteleriCek() async {
    try {
      final int _uniSayisiLimit = 10;
      http.Response uniJson;
      List<Universite> uniCekilen = [];

      final basIndex = ((_sayfa - 1) * _uniSayisiLimit) + 1;
      uniJson = await http.get(
          'https://danisman-akademi-94376.firebaseio.com/universiteler.json?auth=${user.token}&orderBy="uniId"&startAt=$basIndex&limitToFirst=$_uniSayisiLimit');
      _sayfa += 1;

      final Map<String, dynamic> veri = jsonDecode(uniJson.body);
      veri.forEach((f, s) {
        final Universite uni = Universite(
            uniAd: s['uniAd'].toString(),
            uniAdres: s['uniAdres'].toString(),
            uniId: s['uniId'].toString(),
            uniKod: s['uniKodu'].toString(),
            uniMail: s['uniMail'].toString());
        uniCekilen.add(uni);
      });

      _uniler.addAll(uniCekilen);

      notifyListeners();
    } on SocketException {
      throw "Sunucuyla bağlanırken sorun oluştu.";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> aramaYap(String aramaText) async {
    try {
      _searchUniler.clear();
      List<Universite> uniCekilen = [];
      http.Response uniJson = await http.get(
          'https://danisman-akademi-94376.firebaseio.com/universiteler.json?orderBy="uniId"&startAt=1');

      final Map<String, dynamic> veri = jsonDecode(uniJson.body);
      veri.forEach((f, s) {
        final Universite uni = Universite(
            uniAd: s['uniAd'].toString(),
            uniAdres: s['uniAdres'].toString(),
            uniId: s['uniId'].toString(),
            uniKod: s['uniKodu'].toString(),
            uniMail: s['uniMail'].toString());
        uniCekilen.add(uni);
      });
      uniCekilen = uniCekilen.where((uni) {
        RegExp regex = RegExp(aramaText.toLowerCase(), caseSensitive: false);

        return regex.hasMatch(uni.uniAd.toLowerCase());
      }).toList();
      _searchUniler = uniCekilen;
      notifyListeners();
    } on SocketException {
      throw "Sunucuyla bağlanırken sorun oluştu.";
    } catch (e) {
      throw e.toString();
    }
  }

  List<Universite> get searchResult {
    return _searchUniler;
  }

  List<Universite> get universiteler {
    return _uniler;
  }
}
