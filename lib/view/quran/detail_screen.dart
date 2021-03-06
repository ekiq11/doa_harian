// ignore_for_file: avoid_print

import 'package:doa_harian/model/asset.dart';
import 'package:doa_harian/model/ayah.dart';
import 'package:doa_harian/model/surah.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  final Surah? surah;

  const DetailScreen({Key? key, this.surah}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Ayah> _listAyah = [];
  bool isVisible = true;

  void mapAyah() {
    setState(() {
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
                'Tafsir Kemenag - ' '${widget.surah!.latin} : ${index + 1}',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 12.0, right: 8.0, bottom: 6.0),
                  //   child: Directionality(
                  //     textDirection: TextDirection.rtl,
                  //     child: Text(
                  //       _listAyah[index].arabic.toString(),
                  //       textAlign: TextAlign.justify,
                  //       textDirection: TextDirection.rtl,
                  //       style: const TextStyle(
                  //         fontSize: 24,
                  //         fontFamily: "Utsmani",
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      _listAyah[index].tafsir.toString(),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              SizedBox(
                height: 50.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber, // background
                      onPrimary: Colors.black, // foreground
                    ),
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.surah!.latin}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Get.isDarkMode
                          ? isVisible == true
                              ? const Icon(Icons.visibility,
                                  color: Colors.white)
                              : const Icon(Icons.visibility_off,
                                  color: Colors.white)
                          : isVisible == false
                              ? const Icon(Icons.visibility_off,
                                  color: Colors.black87)
                              : const Icon(Icons.visibility,
                                  color: Colors.black87),
                    ),
                  ],
                ),
                elevation: 0,
                pinned: true,
                expandedHeight: 340,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Get.isDarkMode
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 42,
                                    child: Image.asset(
                                      BaseImage.surat(
                                          nomor: '${widget.surah!.number}'),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 42,
                                    child: Image.asset(
                                      BaseImage.surat(
                                          nomor: '${widget.surah!.number}'),
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                          Text(
                            '${widget.surah!.latin}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${widget.surah!.totalAyah} Ayat',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
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
                                  height: widget.surah!.latin == 'At-Taubah'
                                      ? 50
                                      : 40,
                                  child: widget.surah!.latin == 'At-Taubah'
                                      ? Image.asset(
                                          BaseImage.taawuz,
                                          color: Colors.white,
                                        )
                                      : Image.asset(
                                          BaseImage.bismillah,
                                          color: Colors.white,
                                        ),
                                )
                              : Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: widget.surah!.latin == 'At-Taubah'
                                      ? 50
                                      : 40,
                                  child: widget.surah!.latin == 'At-Taubah'
                                      ? Image.asset(
                                          BaseImage.taawuz,
                                          color: Colors.black87,
                                        )
                                      : Image.asset(
                                          BaseImage.bismillah,
                                          color: Colors.black87,
                                        ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 28.0, right: 28.0, top: 12.0),
                            child: widget.surah!.latin == 'At-Taubah'
                                ? const Text(
                                    "Aku berlindung kepada Allah dari godaan syaitan yang terkutuk",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  )
                                : const Text(
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
              ),
            ];
          },
          body: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: widget.surah!.totalAyah,
              itemBuilder: (BuildContext ctx, int index) {
                return Column(
                  children: [
                    InkWell(
                      onLongPress: () {
                        // ignore: prefer_const_declarations
                        final snackBar = const SnackBar(
                          content: Text('Berhasil di copy'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        FlutterClipboard.copy('Allah berfirman : ' '\n\n' +
                                _listAyah[index].arabic.toString() +
                                "\n" +
                                _listAyah[index].indonesia.toString() +
                                '\n\n' +
                                'QS: ${widget.surah!.latin} : ' +
                                '${index + 1}')
                            .then((value) => print('copied'));
                      },
                      onTap: () {
                        showTafsir(context, index);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 18.0, left: 8.0),
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
                                        fontSize: 12,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, right: 8.0, bottom: 6.0),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        _listAyah[index].arabic.toString(),
                                        textAlign: TextAlign.justify,
                                        textDirection: TextDirection.rtl,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontFamily: "Utsmani",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isVisible,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, bottom: 6.0, right: 8.0),
                                      child: Text(
                                        _listAyah[index].indonesia.toString(),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(fontSize: 15.0),
                                      ),
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
      ),
    );
  }
}
