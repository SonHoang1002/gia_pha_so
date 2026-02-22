import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class AssetUtil {
 

  // Đọc từ file trong project
  static Future<dynamic> load(String filePath) async {
    final file = File(filePath);
    try {
      if (!await file.exists()) {
        throw Exception('File không tồn tại');
      }

      final String response = await rootBundle.loadString(filePath);
      final data = jsonDecode(response);
      return data;
    } catch (e) {
      throw Exception('Không thể đọc file: file = $file');
    }
  }
}
