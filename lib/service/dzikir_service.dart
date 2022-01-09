import 'package:doa_harian/model/model_dzikir.dart';
import 'package:flutter/services.dart';

class DzikirService {
  static Future<List<Dzikir>?> readFile() async {
    try {
      final response = await rootBundle.loadString('asset/json/dzikir.json');
      final List<Dzikir> dataDzikir = dzikirFromJson(response);
      print(response);
      return dataDzikir;
    } catch (e) {
      return null;
    }
  }
}
