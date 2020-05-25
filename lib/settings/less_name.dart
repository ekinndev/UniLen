import '../settings/colors.dart';
import '../settings/icons.dart';

class LessName {
  
  static const Map<String,dynamic> tytmat = {'ad':'TYT Matematik','kod':'tytmat','icon':DanIcons.matIcon,'renk':DanColor.matRenk,'lottie':'assets/lottie/mat.json'};
  static const Map<String,dynamic> tytturkce = {'ad':'TYT Türkçe','kod':'tytturkce','icon':DanIcons.turkceIcon,'renk':DanColor.edebRenk,'lottie':'assets/lottie/turkce.json'};
  static const Map<String,dynamic> tytfizik = {'ad':'TYT Fizik','kod':'tytfiz','icon':DanIcons.fizikIcon,'renk':DanColor.fizikRenk,'lottie':'assets/lottie/fizik.json'};
  static const Map<String,dynamic> tytkimya = {'ad':'TYT Kimya','kod':'tytkim','icon':DanIcons.kimIcon,'renk':DanColor.kimRenk,'lottie':'assets/lottie/kimya.json'};
  static const Map<String,dynamic> tytbio = {'ad':'TYT Biyoloji','kod':'tytbio','icon':DanIcons.bioIcon,'renk':DanColor.bioRenk,'lottie':'assets/lottie/bio.json'};
  static const Map<String,dynamic> tyttarih= {'ad':'TYT Tarih','kod':'tyttar','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk,'lottie':'assets/lottie/history.json'};
  static const Map<String,dynamic> tytcog = {'ad':'TYT Coğrafya','kod':'tytcog','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk,'lottie':'assets/lottie/cog.json'};
  static const Map<String,dynamic> tytfel = {'ad':'TYT Fel. ve Din','kod':'tytfel','icon':DanIcons.felseDinIcon,'renk':DanColor.felseDinRenk,'lottie':'assets/lottie/feldin.json'};
  
  static const List tytDersler=[tytmat,tytturkce,tytfizik,tytkimya,tytbio,tyttarih,tytcog,tytfel];


  static const Map<String,dynamic> aytmat = {'ad':'AYT Matematik','kod':'aytmat','icon':DanIcons.matIcon,'renk':DanColor.matRenk,'lottie':'assets/lottie/mat.json'};
  static const Map<String,dynamic> aytfiz = {'ad':'AYT Fizik','kod':'aytfiz','icon':DanIcons.fizikIcon,'renk':DanColor.fizikRenk,'lottie':'assets/lottie/fizik.json'};
  static const Map<String,dynamic> aytkim = {'ad':'AYT Kimya','kod':'aytkim','icon':DanIcons.kimIcon,'renk':DanColor.kimRenk,'lottie':'assets/lottie/kimya.json'};
  static const Map<String,dynamic> aytbio = {'ad':'AYT Biyoloji','kod':'aytbio','icon':DanIcons.bioIcon,'renk':DanColor.bioRenk,'lottie':'assets/lottie/bio.json'};
 
  static const List sayDersler=[aytmat,aytfiz,aytkim,aytbio];

  static const Map<String,dynamic> aytedeb = {'ad':'AYT Edebiyat','kod':'aytedeb','icon':DanIcons.turkceIcon,'renk':DanColor.edebRenk,'lottie':'assets/lottie/turkce.json'};
  static const Map<String,dynamic> aytcog1 = {'ad':'AYT Coğrafya-1','kod':'aytcog1','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk,'lottie':'assets/lottie/cog.json'};
  static const Map<String,dynamic> ayttar1 = {'ad':'AYT Tarih-1','kod':'ayttar1','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk,'lottie':'assets/lottie/history.json'};

  static const List eaDersler=[aytmat,aytedeb,aytcog1,ayttar1];


  static const Map<String,dynamic> ayttar2 = {'ad':'AYT Tarih-2','kod':'ayttar2','icon':DanIcons.tarihIcon,'renk':DanColor.tarihRenk,'lottie':'assets/lottie/history.json'};
  static const Map<String,dynamic> aytcog2= {'ad':'AYT Coğrafya-2','kod':'aytcog2','icon':DanIcons.cogIcon,'renk':DanColor.cogRenk,'lottie':'assets/lottie/cog.json'};
  static const Map<String,dynamic> aytfel = {'ad':'AYT Fel. ve Din','kod':'aytfel','icon':DanIcons.felseDinIcon,'renk':DanColor.felseDinRenk,'lottie':'assets/lottie/feldin.json'};

  static const List sozDersler=[aytedeb,aytcog1,ayttar1,aytcog2,ayttar2,aytfel];
}