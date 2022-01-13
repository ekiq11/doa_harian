import 'package:doa_harian/view/doa_dzikir/dzikir.dart';
import 'package:doa_harian/view/quran/home_screen.dart';
import 'package:doa_harian/view/search/cari.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class HomeTabs extends StatefulWidget {
  HomeTabs({Key? key}) : super(key: key);

  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  _HomeTabsState() {
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (controller == null) {
      controller = TabController(length: 2, vsync: this);
    }

    return SafeArea(
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
                  "Dzikir",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
            controller: controller,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Get.isDarkMode ? Colors.white : Colors.amber,
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.menu_book_sharp),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text("Al-Qur'an"),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ColorfulSafeArea(
          child: TabBarView(
            children: const <Widget>[SearchDoa(), Dzikir()],
            controller: controller,
          ),
        ),
      ),
    );
  }
}
