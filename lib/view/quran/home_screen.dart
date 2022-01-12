import 'dart:convert';
import 'package:doa_harian/model/asset.dart';
import 'package:doa_harian/model/surah.dart';
import 'package:doa_harian/view/quran/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../tab_bar.dart';

class HomeScreen extends StatefulWidget {
  final String? title;

  HomeScreen({Key? key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;
  final List<Surah> _listSurah = [];
  final List<Surah> _listTemp = [];
  final int _totalSurah = 114;
  double _percentage = 0;
  final TextEditingController _searchController = TextEditingController();

  void loadSurah() async {
    setState(() {
      _loading = true;
      _listSurah.clear();
      _listTemp.clear();
      _percentage = 0;
    });

    for (var i = 1; i <= _totalSurah; i++) {
      String raw =
          await rootBundle.loadString('asset/quran-json/surah/$i.json');
      var obj = json.decode(raw);
      var item = Surah.fromJson(obj['$i']);

      setState(() {
        _listTemp.add(item);
        _percentage = (_listTemp.length / _totalSurah) * 100;
      });
    }

    setState(() {
      _loading = false;
      _listSurah.addAll(_listTemp);
    });
  }

  Widget renderBody() {
    return Column(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: Colors.black26),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
            style: const TextStyle(color: Colors.black87),
            autofocus: false,
            autocorrect: false,
            controller: _searchController,
            decoration: const InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
              hintText: 'Cari Surat',
              hintStyle: TextStyle(color: Colors.black54),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                _listTemp.clear();
                _listTemp.addAll(value.isNotEmpty
                    ? _listSurah.where((surah) => surah.latin!
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    : _listSurah);
              });
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _listTemp.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Divider(),
            ),
            itemBuilder: (BuildContext ctx, int index) {
              return ListTile(
                title: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 8),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  BaseImage.numbering,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "${_listTemp[index].number}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Surat ${_listTemp[index].latin}',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                _listTemp[index].name.toString(),
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Text(
                            _listTemp[index].arabic.toString(),
                            style: const TextStyle(
                                fontFamily: "Utsmani", fontSize: 18.0),
                          ),
                          Text(
                            '${_listTemp[index].totalAyah} Ayat',
                            style: const TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext c) =>
                            DetailScreen(surah: _listTemp[index]),
                      ));
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    this.loadSurah();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "سنة",
                style: TextStyle(fontFamily: 'Suls', fontSize: 28),
              ),
              Text(
                "القرآن",
                style: TextStyle(fontFamily: 'Utsmani', fontSize: 24),
              ),
            ],
          ),
        ),
        body: _loading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      strokeWidth: 10,
                      // child: Text(
                      //   '${_percentage.round()}%',
                      //   style: const TextStyle(fontSize: 35),
                      // ),
                    ),
                  ],
                ),
              )
            : renderBody(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeTabs()));
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.menu_book_sharp),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text("Doa dan Dzikir"),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
