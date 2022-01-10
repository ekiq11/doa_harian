import 'package:doa_harian/model/model_dzikir.dart';
import 'package:doa_harian/service/dzikir_service.dart';
import 'package:flutter/material.dart';
import 'detail_dzikir.dart';

class DzikirPagiPetang extends StatefulWidget {
  const DzikirPagiPetang({Key? key}) : super(key: key);

  @override
  State<DzikirPagiPetang> createState() => _DzikirPagiPetangState();
}

class _DzikirPagiPetangState extends State<DzikirPagiPetang> {
  List<Dzikir> _dataDzikir = [];
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  _getData() {
    DzikirService.readFile().then((dataDzikir) {
      setState(() {
        _dataDzikir = dataDzikir!;
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
          itemCount: _dataDzikir.isNotEmpty ? _dataDzikir.length : 0,
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
                          builder: (context) => DetailDzikir(
                              nama: _dataDzikir[snapshot].nama,
                              lafal: _dataDzikir[snapshot].lafal,
                              transliterasi:
                                  _dataDzikir[snapshot].transliterasi,
                              arti: _dataDzikir[snapshot].arti,
                              riwayat: _dataDzikir[snapshot].riwayat,
                              keterangan: _dataDzikir[snapshot].keterangan,
                              footnote: _dataDzikir[snapshot].footnote),
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
                            _dataDzikir[snapshot].idDzikir.toString(),
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
                                    _dataDzikir[snapshot].nama.toString(),
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
