import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class DetailDoa extends StatefulWidget {
  final String? nama;
  final String? lafal;
  final String? transliterasi;
  final String? arti;
  final String? riwayat;
  final String? keterangan;

  const DetailDoa(
      {Key? key,
      this.nama,
      this.lafal,
      this.transliterasi,
      this.arti,
      this.riwayat,
      this.keterangan})
      : super(key: key);

  @override
  _DetailDoaState createState() => _DetailDoaState();
}

class _DetailDoaState extends State<DetailDoa> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Back",
            style: TextStyle(fontSize: 16.0),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: InkWell(
            onLongPress: () {
              // ignore: prefer_const_declarations
              final snackBar = const SnackBar(
                content: Text('Berhasil di copy'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              FlutterClipboard.copy(widget.nama.toString() +
                      "\n\n" +
                      widget.lafal.toString() +
                      '\n\n' +
                      widget.arti.toString())
                  .then((value) => print('copied'));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
                  child: Text(
                    widget.nama.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Divider(
                    height: 2.0,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 16.0),
                  child: Text(
                    widget.lafal.toString(),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(fontSize: 24, fontFamily: 'Utsmani'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: widget.transliterasi != null
                      ? Text(
                          widget.transliterasi.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        )
                      : const Text(""),
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.arti.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16
                        // fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 12.0),
                  child: Divider(
                    height: 2.0,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  child: Text(
                    widget.riwayat.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: widget.keterangan != null
                      ? Text(
                          widget.keterangan.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        )
                      : const Text(""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
