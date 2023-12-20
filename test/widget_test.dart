import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Uri url = Uri.parse('https://api.quran.gading.dev/surah/');
  // var res = await http.get(url);

  // var data = (json.decode(res.body) as Map<String, dynamic>)['data'];

  // // 1-114 -> index ke-113 = An nas
  // //print(data[113]['number']);

  // // data dari API(raw data) => Model(yang sudah dibuat)
  // Surah surahAnnas = Surah.fromJson(data[113]);
  // // print(surahAnnas.name);
  // // print('===========');
  // // print(surahAnnas.number);
  // // print('===========');
  // // print(surahAnnas.numberOfVerses);
  // // print('===========');
  // // print(surahAnnas.revelation);
  // // print('===========');
  // // print(surahAnnas.sequence);
  // // print('===========');
  // // print(surahAnnas.tafsir);

  // // Ini coba masuk ke nested model
  // // print(surahAnnas.number);

  // Uri urlAnnas =
  //     Uri.parse('https://api.quran.gading.dev/surah/${surahAnnas.number}');
  // var resAnnas = await http.get(urlAnnas);

  // //print(resAnnas.body);

  // Map<String, dynamic> dataAnnas =
  //     (json.decode(resAnnas.body) as Map<String, dynamic>)['data'];

  // // print(dataAnnas);

  // // data dari API(raw data) => Model(yang sudah dibuat)
  // DetailSurah annas = DetailSurah.fromJson(dataAnnas);

  // print(annas.verses![0].text!.arab);

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah/$id');

    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];
    DetailSurah test = DetailSurah.fromJson(data);
    print(test);

    return DetailSurah.fromJson(data);
  }

  await getDetailSurah(1.toString());
}
