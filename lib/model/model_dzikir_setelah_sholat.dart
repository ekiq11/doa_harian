// To parse this JSON data, do
//
//     final setelahSholat = setelahSholatFromJson(jsonString);

import 'dart:convert';

List<SetelahSholat> setelahSholatFromJson(String str) =>
    List<SetelahSholat>.from(
        json.decode(str).map((x) => SetelahSholat.fromJson(x)));

String setelahSholatToJson(List<SetelahSholat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SetelahSholat {
  SetelahSholat({
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
  dynamic keterangan;
  String? footnote;

  factory SetelahSholat.fromJson(Map<String, dynamic> json) => SetelahSholat(
        idDzikir: json["id_dzikir"],
        nama: json["nama"],
        lafal: json["lafal"],
        transliterasi: json["transliterasi"],
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
