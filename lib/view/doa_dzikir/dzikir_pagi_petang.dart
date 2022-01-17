import 'package:clipboard/clipboard.dart';
import 'package:doa_harian/model/model_dzikir.dart';
import 'package:doa_harian/service/dzikir_service.dart';
import 'package:flutter/material.dart';

class DzikirPagiPetang extends StatefulWidget {
  const DzikirPagiPetang({Key? key}) : super(key: key);

  @override
  State<DzikirPagiPetang> createState() => _DzikirPagiPetangState();
}

class _DzikirPagiPetangState extends State<DzikirPagiPetang> {
  List<Dzikir> _dataDzikir = [];
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    DzikirService.readFile().then((dataDzikir) {
      setState(() {
        _dataDzikir = dataDzikir!;
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
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "Dzikir Pagi dan Sore",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        body: Center(
          child: PageView.builder(
            itemCount: _dataDzikir.isNotEmpty ? _dataDzikir.length : 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, snapshot) {
              if (snapshot != null) {
                return SingleChildScrollView(
                  child: InkWell(
                    onLongPress: () {
                      // ignore: prefer_const_declarations
                      final snackBar = const SnackBar(
                        content: Text('Berhasil di copy'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      FlutterClipboard.copy(
                              _dataDzikir[snapshot].nama.toString() +
                                  "\n\n" +
                                  _dataDzikir[snapshot].lafal.toString() +
                                  '\n\n' +
                                  _dataDzikir[snapshot].arti.toString())
                          .then((value) => print('copied'));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0,
                                  left: 12.0,
                                  right: 12.0,
                                  bottom: 8.0),
                              child: Text(
                                _dataDzikir[snapshot].nama.toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.00),
                              child: _dataDzikir[snapshot].keterangan != null
                                  ? Text(
                                      _dataDzikir[snapshot]
                                          .keterangan
                                          .toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Divider(
                                      height: 2.0,
                                    ),
                            ),
                          ],
                        ),
                        _dataDzikir[snapshot].keterangan != null
                            ? const Padding(
                                padding: EdgeInsets.only(
                                    left: 12.0, right: 12, top: 12.0),
                                child: Divider(
                                  height: 2.0,
                                ),
                              )
                            : const Padding(padding: EdgeInsets.all(0.0)),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 12.0),
                          child: _dataDzikir[snapshot].lafal != null
                              ? Text(
                                  _dataDzikir[snapshot].lafal.toString(),
                                  textAlign: TextAlign.justify,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                      fontSize: 24, fontFamily: 'Utsmani'),
                                )
                              // ignore: avoid_unnecessary_containers
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12.0, top: 12.0),
                                  child: Text(
                                    _dataDzikir[snapshot].arti.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                        ),
                        _dataDzikir[snapshot].transliterasi != null
                            ? Container(
                                margin: const EdgeInsets.all(12.0),
                                child: Text(
                                  _dataDzikir[snapshot]
                                      .transliterasi
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic),
                                ))
                            : Container(
                                margin: const EdgeInsets.only(
                                    top: 12.0, left: 12.0, right: 12.0),
                              ),
                        _dataDzikir[snapshot].lafal != null
                            ? Container(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  _dataDzikir[snapshot].arti.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 16
                                      // fontStyle: FontStyle.italic,
                                      ),
                                ),
                              )
                            : const Text(""),
                        _dataDzikir[snapshot].footnote != null
                            ? Container(
                                margin: const EdgeInsets.all(12.0),
                                child: Text(
                                  _dataDzikir[snapshot].footnote.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 16),
                                ))
                            : Container(),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Divider(
                            height: 2.0,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
                          child: Text(
                            _dataDzikir[snapshot].riwayat.toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
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
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
}
