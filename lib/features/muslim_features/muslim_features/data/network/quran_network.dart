import 'package:http/http.dart' as http;
import 'dart:convert';

class quran_network {
// get Quran list
  static Future<List<dynamic>> getQuranList() async {
    final response =
        await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      //  final List<dynamic> quranList = [];

      final List<dynamic> quranList = data["data"] as List<dynamic>;
      // for (int i = 0; i < data.length; i++) {
      //   quranList.add({
      //     'id': data[i]['number'],
      //     'name': data[i]['name'],
      //     'englishName': data[i]['englishName'],
      //     'englishNameTranslation': data[i]['englishNameTranslation'],
      //     'revelationType': data[i]['revelationType'],
      //     'numberOfAyahs': data[i]['numberOfAyahs'],
      //   });
      // }

      return quranList;
    } else {
      throw Exception('Failed to load Quran list');
    }
  }

// get Surah
  static Future<List<dynamic>> getSurah(int id, String langage) async {
    final response = await http
        .get(Uri.parse('https://api.alquran.cloud/v1/surah/$id/$langage.asad'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      List<dynamic> surah = data['data']['ayahs'] as List<dynamic>;

      return surah;
    } else {
      throw Exception('Failed to load Surah');
    }
  }

  static Future<String> getSurahAudio(int id, int chapter_number) async {
    final response = await http.get(Uri.parse(
        'https://api.quran.com/api/v4/chapter_recitations/$id/$chapter_number'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final String audio = data['audio_file']['audio_url'] as String;
      print(audio);
      return audio;
    } else {
      throw Exception('Failed to load Surah audio');
    }
  }

  static Future<List<dynamic>> getReciters(String lang) async {
    final response = await http.get(Uri.parse(
        'https://api.quran.com/api/v4/resources/recitations?language=$lang'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final List<dynamic> reciters = data['recitations'] as List<dynamic>;
      return reciters;
    } else {
      throw Exception('Failed to load Reciters');
    }
  }
}
