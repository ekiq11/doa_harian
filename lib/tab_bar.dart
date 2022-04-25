// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:doa_harian/view/doa_dzikir/dzikir.dart';
import 'package:doa_harian/view/quran/home_screen.dart';
import 'package:doa_harian/view/search/cari.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "سنة",
                  style: TextStyle(fontFamily: 'Quran', fontSize: 40),
                ),
              ],
            ),
            elevation: 0,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.changeTheme(Get.isDarkMode
                          ? ThemeData.light()
                          : ThemeData.dark());
                    },
                    child: Get.isDarkMode
                        ? const Icon(Icons.light_mode)
                        : const Icon(Icons.dark_mode),
                  )),
            ],
            bottom: const TabBar(
              tabs: <Tab>[
                Tab(
                  child: Text(
                    "Doa Harian",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Tab(
                  child: Text(
                    "Dzikir",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'btn2',
            backgroundColor: Get.isDarkMode ? Colors.white : Colors.amber,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: Image.asset("asset/icon/iconquran2.png",
                          fit: BoxFit.fitWidth, width: 35.0),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text("Al-Qur'an"),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: const ColorfulSafeArea(
            child: TabBarView(
              children: const [SearchDoa(), Dzikir()],
            ),
          ),
        ),
      ),
    );
  }
}
