import 'package:uniapp/settings/colors.dart';
import 'package:uniapp/settings/icons.dart';

class LessName {
  static const Map<String,dynamic> tytmat = {'ad':'TYT Matematik','kod':'tytmat','icon':DanIcons.matIcon,'renk':DanColor.matRenk};
  static const Map<String,dynamic> tytturkce = {'ad':'TYT Türkçe','kod':'tytturk','icon':DanIcons.turkceIcon,'renk':DanColor.edebRenk};
  static const Map<String,dynamic> tytfizik = {'ad':'TYT Fizik','kod':'tytfiz','icon':DanIcons.fizikIcon,'renk':DanColor.fizikRenk};
  static const Map<String,dynamic> tytkimya = {'ad':'TYT Kimya','kod':'tytkim','icon':DanIcons.kimIcon,'renk':DanColor.kimRenk};
  static const Map<String,dynamic> tytbio = {'ad':'TYT Biyoloji','kod':'tytbio','icon':DanIcons.bioIcon,'renk':DanColor.bioRenk};
  static const Map<String,dynamic> tyttarih= {'ad':'TYT Tarih','kod':'tyttar','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk};
  static const Map<String,dynamic> tytcog = {'ad':'TYT Coğrafya','kod':'tytcog','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk};
  static const Map<String,dynamic> tytfel = {'ad':'TYT Felsefe ve Din','kod':'tytfel','icon':DanIcons.felseDinIcon,'renk':DanColor.felseDinRenk};
  
  static const List tytDersler=[tytmat,tytturkce,tytfizik,tytkimya,tytbio,tyttarih,tytcog,tytfel];


  static const Map<String,dynamic> aytmat = {'ad':'AYT Matematik','kod':'aytmat','icon':DanIcons.matIcon,'renk':DanColor.matRenk};
  static const Map<String,dynamic> aytfiz = {'ad':'AYT Fizik','kod':'aytfiz','icon':DanIcons.fizikIcon,'renk':DanColor.fizikRenk};
  static const Map<String,dynamic> aytkim = {'ad':'AYT Kimya','kod':'aytkim','icon':DanIcons.kimIcon,'renk':DanColor.kimRenk};
  static const Map<String,dynamic> aytbio = {'ad':'AYT Biyoloji','kod':'aytbio','icon':DanIcons.bioIcon,'renk':DanColor.bioRenk};
 
  static const List sayDersler=[aytmat,aytfiz,aytkim,aytbio];

  static const Map<String,dynamic> aytedeb = {'ad':'AYT Edebiyat','kod':'aytedeb','icon':DanIcons.turkceIcon,'renk':DanColor.edebRenk};
  static const Map<String,dynamic> aytcog1 = {'ad':'AYT Coğrafya-1','kod':'aytcog1','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk};
  static const Map<String,dynamic> ayttar1 = {'ad':'AYT Tarih-1','kod':'ayttar1','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk};

  static const List eaDersler=[aytmat,aytedeb,aytcog1,ayttar1];


  static const Map<String,dynamic> ayttar2 = {'ad':'AYT Tarih-2','kod':'ayttar2','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk};
  static const Map<String,dynamic> aytcog2= {'ad':'AYT Coğrafya-2','kod':'aytcog2','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk};
  static const Map<String,dynamic> aytfel = {'ad':'AYT Felsefe ve Din','kod':'aytfel','icon':DanIcons.felseDinIcon,'renk':DanColor.felseDinRenk};

  static const List sozDersler=[aytmat,aytedeb,aytcog1,ayttar1,ayttar2,aytcog2,aytfel];
}