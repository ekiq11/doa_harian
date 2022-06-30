import 'package:doa_harian/view/doa_dzikir/dzikir.dart';
import 'package:doa_harian/view/quran/home_screen.dart';
import 'package:doa_harian/view/search/cari.dart';
import 'package:flutter/material.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('asset/doa.png', width: 70),
              ],
            ),
            elevation: 0,
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
            backgroundColor: Colors.amber,
            //shadow

            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                  child: Text("Al-Qur'an", style: TextStyle(fontSize: 14.0)),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: const ColorfulSafeArea(
            child: TabBarView(
              children: [SearchDoa(), Dzikir()],
            ),
          ),
        ),
      ),
    );
  }
}
