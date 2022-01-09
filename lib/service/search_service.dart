import 'dart:convert';

import 'package:doa_harian/model/model_doa.dart';
import 'package:flutter/services.dart';

class SearchService {
  static Future<List<Doa>?> readFile(String query) async {
    try {
      final response = await rootBundle.loadString('asset/json/doa.json');
      final List data = json.decode(response);
      return data.map((json) => Doa.fromJson(json)).where((data) {
        final nama = data.nama.toString().toLowerCase();

        final searchLower = query.toLowerCase();

        return nama.toString().contains(searchLower);
      }).toList();
    } catch (e) {
      return null;
    }
  }
}
