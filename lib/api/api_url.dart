class ApiUrl {
  static const baseUrl = 'https://api.banghasan.com';
  static const surat = '$baseUrl/quran/format/json/surat';

  static Future<String> ayatRange(var nomor, var start, var end) async {
    return '$baseUrl/quran/format/json/surat/$nomor/ayat/$start-$end';
  }
}
