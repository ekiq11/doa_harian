// To parse this JSON data, do
//
//     final doa = doaFromJson(jsonString);

import 'dart:convert';

List<Doa> doaFromJson(String str) =>
    List<Doa>.from(json.decode(str).map((x) => Doa.fromJson(x)));

String doaToJson(List<Doa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doa {
  Doa({
    this.idDoa,
    this.nama,
    this.lafal,
    this.transliterasi,
    this.arti,
    this.riwayat,
    this.keterangan,
    this.kataKunci,
  });

  String? idDoa;
  String? nama;
  String? lafal;
  String? transliterasi;
  String? arti;
  String? riwayat;
  dynamic keterangan;
  List<String>? kataKunci;

  factory Doa.fromJson(Map<String, dynamic> json) => Doa(
        idDoa: json["id_doa"],
        nama: json["nama"],
        lafal: json["lafal"],
        transliterasi: json["transliterasi"],
        arti: json["arti"],
        riwayat: json["riwayat"],
        keterangan: json["keterangan"],
        kataKunci: List<String>.from(json["kata_kunci"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_doa": idDoa,
        "nama": nama,
        "lafal": lafal,
        "transliterasi": transliterasi,
        "arti": arti,
        "riwayat": riwayat,
        "keterangan": keterangan,
        "kata_kunci": List<dynamic>.from(kataKunci!.map((x) => x)),
      };
}
