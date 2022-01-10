import 'package:doa_harian/model/model_doa.dart';
import 'package:doa_harian/service/doa_service.dart';
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

  _getData() {
    DoaServices.readFile().then((data) {
      setState(() {
        _dataDoa = data;
      });
    });
  }

  _loading() {
    for (int i = 0; i < 2; i++) {
      _getData();
    }
  }

  @override
  void initState() {
    super.initState();
    _loading();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset >= 400) {
          _showBackToTopButton = true; // show the back-to-top button
        } else {
          _showBackToTopButton = false; // hide the back-to-top button
        }
      });
      print(_scrollController.position.pixels);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loading;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                              transliterasi: _dataDoa[snapshot].transliterasi,
                              arti: _dataDoa[snapshot].arti,
                              riwayat: _dataDoa[snapshot].riwayat,
                              keterangan: _dataDoa[snapshot].keterangan),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Text(
                            _dataDoa[snapshot].idDoa.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.5),
                                  child: Text(
                                    _dataDoa[snapshot].nama.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
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
                            size: 16,
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
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
              backgroundColor: Colors.amber,
            ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
}
