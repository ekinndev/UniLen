import 'package:flutter/material.dart';

class KonuProvider with ChangeNotifier {
  List<Map<String, Object>> _degerler = [
    {"konu": "Temel Kavramlar"},
    {"konu": "Sayı Basamakları"},
    {"konu": "Bölme ve Bölünebilme"},
    {"konu": "OBEB-OKEK"},
    {"konu": "Rasyonel Sayılar"},
    {"konu": "Ondalık Sayılar"},
    {"konu": "Basit Eşitsizlikler"},
    {"konu": "Mutlak Değer"},
    {"konu": "Üslü Sayılar"},
    {"konu": "Köklü Sayılar"},
    {"konu": "Çarpanlara Ayırma"},
    {"konu": "Oran Orantı"},
    {"konu": "Denklem Çözme"},
  ];

  List<Map<String, Object>> get degerleriCek {
    return _degerler;
  }

  void durumuGuncelle(int index) {
    if (_degerler[index]['durum'] != null) {
      _degerler[index]['durum'] = !_degerler[index]['durum'];
    } else {
      _degerler[index]['durum'] = true;
    }
    notifyListeners();
  }
}
