// ignore_for_file: unnecessary_null_comparison

import 'package:doa_harian/model/model_doa.dart';
import 'package:doa_harian/service/doa_service.dart';
import 'package:doa_harian/view/search/cari.dart';
import 'package:flutter/material.dart';
import 'detail_doa.dart';

class HomePageDoa extends StatefulWidget {
  const HomePageDoa({Key? key}) : super(key: key);

  @override
  State<HomePageDoa> createState() => _HomePageDoaState();
}

class _HomePageDoaState extends State<HomePageDoa> {
  List<Doa> _dataDoa = [];
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    DoaServices.readFile().then((data) {
      setState(() {
        _dataDoa = data;
      });
    });
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset >= 400) {
          _showBackToTopButton = true; // show the back-to-top button
        } else {
          _showBackToTopButton = false; // hide the back-to-top button
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _dataDoa.isNotEmpty ? _dataDoa.length : 0,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, snapshot) {
                if (snapshot != null) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailDoa(
                                  nama: _dataDoa[snapshot].nama,
                                  lafal: _dataDoa[snapshot].lafal,
                                  transliterasi:
                                      _dataDoa[snapshot].transliterasi,
                                  arti: _dataDoa[snapshot].arti,
                                  riwayat: _dataDoa[snapshot].riwayat,
                                  keterangan: _dataDoa[snapshot].keterangan),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.only(
                              top: 12, left: 16, right: 16),
                          child: Row(
                            children: <Widget>[
                              Text(
                                _dataDoa[snapshot].idDoa.toString(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.5),
                                      child: Text(
                                        _dataDoa[snapshot].nama.toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade500,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 2.0,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
        floatingActionButton: _showBackToTopButton == false
            ? null
            : Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: 'btn3',
                      backgroundColor: Colors.amber,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchDoa()));
                      },
                      child: const Icon(Icons.search),
                    ),
                    FloatingActionButton(
                      heroTag: 'btn4',
                      onPressed: _scrollToTop,
                      child: const Icon(Icons.arrow_upward),
                      backgroundColor: Colors.amber,
                    ),
                  ],
                ),
              ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
}
