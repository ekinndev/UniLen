import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uniapp/models/universite.dart';
import 'package:http/http.dart' as http;
import 'package:uniapp/models/user.dart';

class Uni with ChangeNotifier {
  final User user;
  Uni([this.user]);
  int _sayfa = 3;
  List<Universite> _uniler = [];
  List<Universite> _searchUniler = [];
  Map<String, Object> _universite;

  Future<void> universiteleriCek() async {
    try {
      if(_sayfa >20){
        return;
      }
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
      throw "Sunucuya bağlanırken sorun oluştu.";
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
      throw "Sunucuya bağlanırken sorun oluştu.";
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

  Future<void> uniyiGetir(String uniKod) async {
    try {
      _universite = null;
      final jsonData = await http.get(
          'https://danisman-akademi-94376.firebaseio.com/unibolumbilgi/$uniKod.json');
      final veriler = jsonDecode(jsonData.body);
      _universite = veriler;

      notifyListeners();
    } on SocketException {
      throw 'İnternet bağlantısı ya da veri yok.';
    } catch (e) {
      throw e.toString();
    }
  }

  Map<String, Object> get bolumBilgi {
    return _universite;
  }
}
