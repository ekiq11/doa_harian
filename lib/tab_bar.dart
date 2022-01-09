// ignore_for_file: unnecessary_new

import 'package:doa_harian/view/doa_harian.dart';
import 'package:doa_harian/view/dzikir_pagi_petang.dart';
import 'package:doa_harian/view/search/cari.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class HomeTabs extends StatefulWidget {
  HomeTabs({Key? key}) : super(key: key);

  @override
  _HomeTabsState createState() => new _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  _HomeTabsState() {
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (controller == null) {
      controller = TabController(length: 2, vsync: this);
    }

    return Scaffold(
      appBar: AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "سنة",
              style: TextStyle(fontFamily: 'Suls', fontSize: 34),
            ),
          ],
        ),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                },
                child: Get.isDarkMode
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode),
              )),
        ],
        bottom: TabBar(
          tabs: const <Tab>[
            Tab(
              child: Text(
                "Doa Harian",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Tab(
              child: Text(
                "Dzikir Pagi-Sore",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
          controller: controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FilterLocalListPage()));
        },
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ColorfulSafeArea(
        child: new TabBarView(
          children: const <Widget>[HomePageDoa(), DzikirPagiPetang()],
          controller: controller,
        ),
      ),
    );
  }
}
