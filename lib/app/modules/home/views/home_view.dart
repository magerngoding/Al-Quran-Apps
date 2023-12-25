// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:alquran/app/constants/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al Quran Apps'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualaikum',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Last Read
              Banner(),
              TabBar(
                indicatorColor: appPurpleDark,
                labelColor: appPurpleDark,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Surah',
                  ),
                  Tab(
                    text: 'Juz',
                  ),
                  Tab(
                    text: 'Bookmark',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                        future: controller.getAllSurah(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData) {
                            // ! = TIDAK, jadi tidak punya data
                            Center(
                              child: Text('Tidak ada data!'),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAIL_SURAH,
                                    arguments: surah,
                                  );
                                },
                                leading: CircleAvatar(
                                  child: Text('${surah.number}'),
                                ),
                                title: Text(
                                  surah.name?.transliteration.id ?? 'Erorr',
                                ),
                                subtitle: Text(
                                    '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Erorr...'}'),
                                trailing: Text(
                                  '${surah.name?.short ?? "Erorr"}',
                                ),
                              );
                            },
                          );
                        }),
                    Center(
                      child: Text(
                        'Page 2',
                      ),
                    ),
                    Center(
                      child: Text(
                        'Page 3',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container Banner() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            appPurpleLight1,
            appPurpleDark,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.LAST_READ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                child: Positioned(
                  bottom: 5,
                  right: 5,
                  top: 5,
                  child: Image.network(
                    "https://png.pngtree.com/png-clipart/20220424/original/pngtree-download-beautiful-purple-and-gold-mushaf-al-quran-kareem-time-muslim-png-image_7552361.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_outlined,
                          size: 24.0,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Terakhir dibaca",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Al-Fatihah",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "Juz 1 | Ayat 5",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
