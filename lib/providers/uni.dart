import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/universite.dart';
import 'package:http/http.dart' as http;

class Uni with ChangeNotifier {
  final FirebaseUser _user;
  Uni([this._user]);
  int _sayfa = 3;
  List<Universite> _uniler = [];
  List<Universite> _searchUniler = [];
  Map<String, Object> _universite;
  final String _apiLink = 'https://unilen-75828.firebaseio.com/';

  Future<void> universiteleriCek() async {
    try {
      if (_sayfa > 20) {
        return;
      }
      final token = (await _user.getIdToken()).token;
      final int _uniSayisiLimit = 10;
      http.Response uniJson;
      List<Universite> uniCekilen = [];

      final basIndex = ((_sayfa - 1) * _uniSayisiLimit) + 1;
      uniJson = await http.get(
          '${Constants.apiLink}universiteler.json?auth=$token&orderBy="uniId"&startAt=$basIndex&limitToFirst=$_uniSayisiLimit');
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
      final token = (await _user.getIdToken()).token;
      List<Universite> uniCekilen = [];
      http.Response uniJson = await http.get(
          '${Constants.apiLink}universiteler.json?auth=$token&orderBy="uniId"&startAt=1');

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
      final token = (await _user.getIdToken()).token;
      final jsonData = await http
          .get('${Constants.apiLink}unibolumbilgi/$uniKod.json?auth=$token');
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
