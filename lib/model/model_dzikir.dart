// To parse this JSON data, do
//
//     final dzikir = dzikirFromJson(jsonString);

import 'dart:convert';

List<Dzikir> dzikirFromJson(String str) =>
    List<Dzikir>.from(json.decode(str).map((x) => Dzikir.fromJson(x)));

String dzikirToJson(List<Dzikir> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dzikir {
  Dzikir({
    this.idDzikir,
    this.nama,
    this.lafal,
    this.transliterasi,
    this.arti,
    this.riwayat,
    this.keterangan,
    this.footnote,
  });

  String? idDzikir;
  String? nama;
  String? lafal;
  String? transliterasi;
  String? arti;
  String? riwayat;
  String? keterangan;
  String? footnote;

  factory Dzikir.fromJson(Map<String, dynamic> json) => Dzikir(
        idDzikir: json["id_dzikir"],
        nama: json["nama"],
        lafal: json["lafal"],
        transliterasi:
            json["transliterasi"],
        arti: json["arti"],
        riwayat: json["riwayat"],
        keterangan: json["keterangan"],
        footnote: json["footnote"],
      );

  Map<String, dynamic> toJson() => {
        "id_dzikir": idDzikir,
        "nama": nama,
        "lafal": lafal,
        "transliterasi": transliterasi,
        "arti": arti,
        "riwayat": riwayat,
        "keterangan": keterangan,
        "footnote": footnote,
      };
}
