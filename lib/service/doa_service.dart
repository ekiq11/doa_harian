import 'package:doa_harian/model/model_doa.dart';
import 'package:flutter/services.dart';

class DoaServices {
  static Future<List<Doa>> readFile() async {
    try {
      final response = await rootBundle.loadString('asset/json/doa.json');
      final List<Doa> data = doaFromJson(response);
      print(response);
      return data;
    } catch (e) {
      return throw Exception();
    }
  }
}
