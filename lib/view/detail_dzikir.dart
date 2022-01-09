import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailDzikir extends StatefulWidget {
  final String? nama;
  final String? lafal;
  final String? transliterasi;
  final String? arti;
  final String? riwayat;
  final String? keterangan;
  final String? footnote;

  DetailDzikir(
      {Key? key,
      this.nama,
      this.lafal,
      this.transliterasi,
      this.arti,
      this.riwayat,
      this.keterangan,
      this.footnote})
      : super(key: key);

  @override
  _DetailDzikirState createState() => _DetailDzikirState();
}

class _DetailDzikirState extends State<DetailDzikir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Back",
          style: TextStyle(fontSize: 16),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, left: 12.0, right: 12.0, bottom: 8.0),
                  child: Text(
                    widget.nama.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.00),
                  child: widget.keterangan != null
                      ? Text(
                          widget.keterangan.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.bold),
                        )
                      : const Divider(
                          height: 2.0,
                        ),
                ),
              ],
            ),
            widget.keterangan != null
                ? const Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12, top: 12.0),
                    child: Divider(
                      height: 2.0,
                    ),
                  )
                : const Padding(padding: EdgeInsets.all(0.0)),
            Container(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: widget.lafal != null
                  ? Text(
                      widget.lafal.toString(),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style:
                          const TextStyle(fontSize: 32, fontFamily: 'Utsmani'),
                    )
                  // ignore: avoid_unnecessary_containers
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12.0, top: 12.0),
                      child: Text(
                        widget.arti.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
            ),
            widget.transliterasi != null
                ? Container(
                    margin: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.transliterasi.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16, fontStyle: FontStyle.italic),
                    ))
                : Container(
                    margin: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                  ),
            widget.lafal != null
                ? Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.arti.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16
                          // fontStyle: FontStyle.italic,
                          ),
                    ),
                  )
                : const Text(""),
            widget.footnote != null
                ? Container(
                    margin: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.footnote.toString(),
                      textAlign: TextAlign.justify,
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
                widget.riwayat.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
