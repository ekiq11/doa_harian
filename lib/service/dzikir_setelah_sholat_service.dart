import 'package:doa_harian/model/model_dzikir_setelah_sholat.dart';
import 'package:flutter/services.dart';

class SetelahSholatService {
  static Future<List<SetelahSholat>?> readFile() async {
    try {
      final response =
          await rootBundle.loadString('asset/json/dzikir_setelah_sholat.json');
      final List<SetelahSholat> dataDzikir = setelahSholatFromJson(response);
      print(response);
      return dataDzikir;
    } catch (e) {
      return null;
    }
  }
}
