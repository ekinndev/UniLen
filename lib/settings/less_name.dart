import 'package:uniapp/settings/colors.dart';
import 'package:uniapp/settings/icons.dart';

class LessName {
  
  static const Map<String,dynamic> tytmat = {'ad':'TYT Matematik','kod':'tyt/tytmat','icon':DanIcons.matIcon,'renk':DanColor.matRenk,'lottie':'assets/lottie/mat.json'};
  static const Map<String,dynamic> tytturkce = {'ad':'TYT Türkçe','kod':'tyt/tytturkce','icon':DanIcons.turkceIcon,'renk':DanColor.edebRenk,'lottie':'assets/lottie/turkce.json'};
  static const Map<String,dynamic> tytfizik = {'ad':'TYT Fizik','kod':'tyt/tytfiz','icon':DanIcons.fizikIcon,'renk':DanColor.fizikRenk,'lottie':'assets/lottie/fizik.json'};
  static const Map<String,dynamic> tytkimya = {'ad':'TYT Kimya','kod':'tyt/tytkim','icon':DanIcons.kimIcon,'renk':DanColor.kimRenk,'lottie':'assets/lottie/kimya.json'};
  static const Map<String,dynamic> tytbio = {'ad':'TYT Biyoloji','kod':'tyt/tytbio','icon':DanIcons.bioIcon,'renk':DanColor.bioRenk,'lottie':'assets/lottie/bio.json'};
  static const Map<String,dynamic> tyttarih= {'ad':'TYT Tarih','kod':'tyt/tyttar','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk,'lottie':'assets/lottie/history.json'};
  static const Map<String,dynamic> tytcog = {'ad':'TYT Coğrafya','kod':'tyt/tytcog','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk,'lottie':'assets/lottie/cog.json'};
  static const Map<String,dynamic> tytfel = {'ad':'TYT Fel. ve Din','kod':'tyt/tytfel','icon':DanIcons.felseDinIcon,'renk':DanColor.felseDinRenk,'lottie':'assets/lottie/feldin.json'};
  
  static const List tytDersler=[tytmat,tytturkce,tytfizik,tytkimya,tytbio,tyttarih,tytcog,tytfel];


  static const Map<String,dynamic> aytmat = {'ad':'AYT Matematik','kod':'ayt/aytmat','icon':DanIcons.matIcon,'renk':DanColor.matRenk};
  static const Map<String,dynamic> aytfiz = {'ad':'AYT Fizik','kod':'ayt/Say/aytfiz','icon':DanIcons.fizikIcon,'renk':DanColor.fizikRenk};
  static const Map<String,dynamic> aytkim = {'ad':'AYT Kimya','kod':'ayt/Say/aytkim','icon':DanIcons.kimIcon,'renk':DanColor.kimRenk};
  static const Map<String,dynamic> aytbio = {'ad':'AYT Biyoloji','kod':'ayt/Say/aytbio','icon':DanIcons.bioIcon,'renk':DanColor.bioRenk};
 
  static const List sayDersler=[aytmat,aytfiz,aytkim,aytbio];

  static const Map<String,dynamic> aytedeb = {'ad':'AYT Edebiyat','kod':'ayt/aytedeb','icon':DanIcons.turkceIcon,'renk':DanColor.edebRenk};
  static const Map<String,dynamic> aytcog1 = {'ad':'AYT Coğrafya-1','kod':'ayt/aytcog1','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk};
  static const Map<String,dynamic> ayttar1 = {'ad':'AYT Tarih-1','kod':'ayt/ayttar1','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk};

  static const List eaDersler=[aytmat,aytedeb,aytcog1,ayttar1];


  static const Map<String,dynamic> ayttar2 = {'ad':'AYT Tarih-2','kod':'ayt/soz/ayttar2','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk};
  static const Map<String,dynamic> aytcog2= {'ad':'AYT Coğrafya-2','kod':'ayt/soz/aytcog2','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk};
  static const Map<String,dynamic> aytfel = {'ad':'AYT Fel. ve Din','kod':'ayt/soz/aytfel','icon':DanIcons.felseDinIcon,'renk':DanColor.felseDinRenk};

  static const List sozDersler=[aytedeb,aytcog1,ayttar1,aytcog2,ayttar2,aytfel];
}