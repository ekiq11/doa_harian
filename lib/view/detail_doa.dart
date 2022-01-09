import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailDoa extends StatefulWidget {
  final String? nama;
  final String? lafal;
  final String? transliterasi;
  final String? arti;
  final String? riwayat;
  final String? keterangan;

  DetailDoa(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
              child: Text(
                widget.nama.toString(),
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Divider(
                height: 2.0,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              child: Text(
                widget.lafal.toString(),
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 32, fontFamily: 'Utsmani'),
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
              margin: const EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
              child: const Text(
                "Artinya : ",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              child: Text(
                widget.arti.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16
                    // fontStyle: FontStyle.italic,
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            const Divider(
              height: 2.0,
            ),
            Container(
              margin: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Text(
                widget.riwayat.toString(),
                textAlign: TextAlign.justify,
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
    );
  }
}
