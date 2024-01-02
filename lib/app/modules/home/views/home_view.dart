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
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Al Quran Apps',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
          padding: const EdgeInsets.only(
            top: 20.0,
            right: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Banner(), // Last Read
              TabBar(
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
              surah()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.isDarkMode
              ? Get.changeTheme(themeLight)
              : Get.changeTheme(themeDark);
          controller.isDark.toggle();
        },
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? appPurpleDark : appWhite,
          ),
        ),
      ),
    );
  }

  Expanded surah() {
    return Expanded(
      child: TabBarView(
        children: [
          FutureBuilder<List<Surah>>(
              future: controller.getAllSurah(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                      leading: Obx(
                        () => Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                controller.isDark.isTrue
                                    ? 'assets/images/list_dark.png'
                                    : 'assets/images/list_light.png',
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${surah.number}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        surah.name?.transliteration.id ?? 'Erorr',
                      ),
                      subtitle: Text(
                        '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Erorr...'}',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      trailing: Text(
                        '${surah.name?.short ?? "Erorr"}',
                      ),
                    );
                  },
                );
              }),
          ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                leading: Obx(
                  () => Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          controller.isDark.isTrue
                              ? 'assets/images/list_dark.png'
                              : 'assets/images/list_light.png',
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Juz ${index + 1}',
                ),
              );
            },
          ),
          Center(
            child: Text(
              'Page 3',
            ),
          ),
        ],
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
                  child: Image.asset(
                    "assets/images/banner.png",
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
