// ignore_for_file: prefer_is_empty, prefer_const_constructors

import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments;

  DetailJuzView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${detailJuz.juz}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: detailJuz.verses?.length ?? 0,
        itemBuilder: (context, index) {
          if (detailJuz.verses?.length == null ||
              detailJuz.verses?.length == 0) {
            return Center(
              child: Text(
                "text",
              ),
            );
          }
          juz.Verses ayat = detailJuz.verses![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: appPurpleLight2.withOpacity(0.3),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              Get.isDarkMode
                                  ? 'assets/images/list_dark.png'
                                  : 'assets/images/list_light.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${ayat.number?.inSurah}',
                          ),
                        ),
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
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '${ayat.text?.arab}',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Text(
                '${ayat.text?.transliteration?.en}',
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
                '${ayat.translation?.id}',
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
      ),
    );
  }
}
