// ignore_for_file: prefer_const_constructors

import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;

  DetailSurahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SURAH ${surah.name?.transliteration.id.toUpperCase() ?? 'Erorr'}',
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'SURAH ${surah.name?.transliteration.id.toUpperCase() ?? 'Erorr...'}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'SURAH ${surah.name?.translation.id.toUpperCase() ?? 'Erorr...'}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'SURAH ${surah.numberOfVerses ?? 'Erorr...'} Ayat | ${surah.revelation?.id}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // ! = TIDAK, jadi tidak punya data
              if (!snapshot.hasData) {
                Center(
                  child: Text('Tidak ada data!'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.verses.length ?? 0,
                itemBuilder: (context, index) {
                  if (snapshot.data!.verses?.length == 0) {
                    return SizedBox();
                  }
                  detail.Verse? ayat = snapshot.data!.verses?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.bookmark_add_outlined,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_arrow,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        '${ayat!.text.arab}',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        '${ayat.text.transliteration.en}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        '${ayat.translation.id}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
