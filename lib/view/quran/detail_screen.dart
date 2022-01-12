import 'dart:io';

import 'package:doa_harian/model/asset.dart';
import 'package:doa_harian/model/ayah.dart';
import 'package:doa_harian/model/surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  final Surah? surah;

  DetailScreen({Key? key, this.surah}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _loading = false;
  List<Ayah> _listAyah = [];

  void mapAyah() {
    setState(() {
      _loading = true;
      _listAyah.clear();
    });

    List<Ayah> temp = [];
    for (int i = 0; i < widget.surah!.totalAyah!; i++) {
      var ayah = Ayah();
      ayah.index = i + 1;
      ayah.arabic = widget.surah!.ayah!['${i + 1}'];
      ayah.indonesia = widget.surah!.translation!['${i + 1}'];
      ayah.tafsir = widget.surah!.tafsir!['${i + 1}'];
      temp.add(ayah);
    }

    setState(() {
      _loading = false;
      _listAyah = temp;
    });
  }

  Future<void> showTafsir(context, index) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: const EdgeInsets.all(10),
            title: Text(
                'Tafsir Kemenag - ' + '${widget.surah!.latin} : ${index + 1}',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(_listAyah[index].tafsir.toString()),
                ],
              ),
            ),
            actions: [
              SizedBox(
                height: 50.0,
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.close),
                        Center(
                          child: Text(
                            'Tutup',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 16.0),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    mapAyah();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(
                  '${widget.surah!.latin}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                elevation: 0,
                pinned: true,
                expandedHeight: 320,
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: 40,
                            child: Text('${widget.surah!.arabic}',
                                style: const TextStyle(
                                    fontFamily: 'Suls', fontSize: 24.0))),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Text(
                            '${widget.surah!.latin}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${widget.surah!.totalAyah} Ayat',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 16,
                            bottom: 12,
                          ),
                          child: Divider(
                            endIndent: Get.width / 12,
                            indent: Get.width / 12,
                            height: 2,
                          ),
                        ),
                        Get.isDarkMode
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 42,
                                child: Image.asset(BaseImage.bismillah,
                                    color: Colors.white),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 42,
                                child: Image.asset(BaseImage.bismillah,
                                    color: Colors.black87),
                              ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 24.0, right: 24.0, top: 12.0),
                          child: Text(
                            "Dengan menyebut nama Allah yang maha pengasih lagi maha penyayang",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView.builder(
            itemCount: widget.surah!.totalAyah,
            itemBuilder: (BuildContext ctx, int index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showTafsir(context, index);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 12),
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
                                    "${index + 1}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 6.0, bottom: 6.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      _listAyah[index].arabic.toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: "Utsmani",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 6.0),
                                  child: Text(
                                    _listAyah[index].indonesia.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Divider(
                      height: 2.0,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}