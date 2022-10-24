import 'dart:convert';
import 'package:intl/intl.dart';

class Status {
  static bool debug = false;
}

class Size {
  static double size4 = 4.0;
  static double size8 = 8.0;
  static double size12 = 12.0;
  static double size14 = 14.0;
  static double size16 = 16.0;
  static double size18 = 18.0;
  static double size20 = 20.0;
  static double size24 = 24.0;
  static double size32 = 32.0;
  static double size40 = 40.0;
  static double size64 = 64.0;
}

class Profil {
  static String nama = 'M. Gavin Arasyi';
  static String desc =
      'Ini adalah project saya untuk belajar juga. Silahkan untuk follow projek lainnya di Github saya. Terima kasih banyak';
  static String instagram = 'Instagram';
  static String github = 'Github';
  static String urlInstagram =
      'https://instagram.com/gavinarasyi?igshid=YmMyMTA2M2Y=';
  static String urlGithub = 'https://github.com/Gavin-10RPL2-22';
}

class Data {
  static String suratID = 'suratID';
  static String totalAyat = 'ayat';
  static String suratNama = 'nama';
  static String suratArti = 'arti';
  static String suratType = 'type';
  static List randomSurah = [
    '"Jangan kamu merasa lemah dan jangan bersedih, sebab kamu paling tinggi derajatnya jika kamu beriman." (Q.S Ali Imran: 139)',
    '"Kebaikan tidak sama dengan kejahatan. Tolaklah kejahatan itu dengan cara yang lebih baik sehingga yang memusuhimu akan seperti teman yang setia." (Q.S Fusshilat: 34)',
    '"Hai orang-orang yang beriman, mintalah pertolongan kepada Allah dengan sabar dan salat. Sesungguhnya Allah beserta orang-orang yang sabar." (Q.S Al-Baqarah: 153)',
    '"Telah tampak kerusakan di darat dan di laut disebabkan karena ulah tangan manusia." (Q.S Ar-Rum: 41)',
    '"Di mana saja kamu berada, kematian akan mendapatkanmu, kendati pun kamu berada dalam benteng yang tinggi dan kukuh." (Q.S An-Nisa: 78)',
    '"Tiap-tiap yang berjiwa pasti akan merasakan mati." (Q.S Ali Imran: 185)',
    '"Dan kehidupan dunia ini tidak lain hanyalah kesenangan yang menipu." (Q.S Al-Hadid: 20)',
    '"Sungguh, setan itu tidak ada kekuasaannya atas orang yang beriman dan bertawakal kepada Tuhan." (Q.S An-Nahl: 99)',
    '''"Dan apabila dibacakan Al-Quran, maka dengarkanlah baik-baik, dan perhatikanlah dengan seksama agar kamu mendapat rahmat." (QS. Al-A’raf: 204)''',
    '''"Sesungguhnya Allah tidak akan mengubah nasib suatu kaum sehingga mereka mengubah keadaan yang ada pada diri mereka sendiri." (Q.S Ar-Ra'd: 11)''',
    '''"Apakah manusia itu mengira bahwa mereka dibiarkan (saja) mengatakan, 'Kami telah beriman' sedang mereka tidak diuji lagi?" (Q.S Al-'Ankabut: 2)''',
    '''"Dan barangsiapa berbuat kesalahan atau dosa, kemudian dia tuduhkan kepada orang yang tidak bersalah, maka sungguh dia telah memikul suatu kebohongan dan dosa yang nyata." (Q.S An-Nisa’: 112)''',
    '''"Dan janganlah kamu berbuat kerusakan di muka bumi setelah diciptakan dengan baik." (Q.S Al-A'raf: 56)''',
    '''"Dan tiadalah kehidupan dunia ini, selain dari main-main dan senda gurau belaka. Dan sungguh kampung akhirat itu lebih baik bagi orang-orang yang bertakwa. Maka tidakkah kamu memahaminya?" (Q.S Al-An’am: 32)''',
    '''"Bagi manusia ada malaikat-malaikat yang selalu mengikutinya di hadapan dan di belakangnya, mereka menjaganya atas perintah Allah." (Q.S Ar-Ra’d: 11)''',
    '''"Hai orang yang berselimut! Bangunlah lalu beri peringatan! Dan agungkanlah Tuhanmu! Bersihkanlah pakaianmu dan tinggalkanlah perbuatan dosa." (Q.S Al-Muddattsir: 1-5)'''
  ];
}

class Func {
  static String convertUtf8(String data) {
    var varData = data.codeUnits;
    return utf8.decode(varData);
  }
}
