import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AssetUtil {
  static const String _base = "assets/datas/";
  
  // Load JSON file từ assets
  static Future<dynamic> loadJson(String jsonFileName) async {
    try {
      final String response = await rootBundle.loadString(_base + jsonFileName);
      final data = jsonDecode(response);
      return data;
    } catch (e) {
      throw Exception('Không thể load file $jsonFileName: $e');
    }
  }
  
  // Load JSON và parse thành List
  static Future<List<dynamic>> loadJsonList(String jsonFileName) async {
    final data = await loadJson(jsonFileName);
    return data is List ? data : [data];
  }
  
  // Load JSON và parse thành Map
  static Future<Map<String, dynamic>> loadJsonMap(String jsonFileName) async {
    final data = await loadJson(jsonFileName);
    return data is Map ? Map<String, dynamic>.from(data) : {};
  }
  
  // Load text file
  static Future<String> loadText(String filePath) async {
    try {
      return await rootBundle.loadString('assets/$filePath');
    } catch (e) {
      throw Exception('Không thể load file $filePath: $e');
    }
  }
  
  // Load binary file (image, audio, etc.)
  static Future<ByteData> loadBinary(String filePath) async {
    try {
      return await rootBundle.load('assets/$filePath');
    } catch (e) {
      throw Exception('Không thể load binary file $filePath: $e');
    }
  }
  
  // Get file path từ assets
  static String getAssetPath(String fileName) {
    return 'assets/$fileName';
  }
  
  // Save data to local storage (JSON)
  static Future<void> saveLocalJson(
    String fileName, 
    dynamic data,
  ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      throw Exception('Không thể lưu file $fileName: $e');
    }
  }
  
  // Load data from local storage (JSON)
  static Future<dynamic> loadLocalJson(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      
      if (await file.exists()) {
        final contents = await file.readAsString();
        return jsonDecode(contents);
      }
      return null;
    } catch (e) {
      throw Exception('Không thể load local file $fileName: $e');
    }
  }
  
  // Delete local file
  static Future<void> deleteLocalFile(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Không thể xóa file $fileName: $e');
    }
  }
  
  // Check if file exists in local storage
  static Future<bool> localFileExists(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      return await file.exists();
    } catch (e) {
      return false;
    }
  }
  
  // Copy asset to local storage
  static Future<File> copyAssetToLocal(
    String assetPath, 
    String localFileName,
  ) async {
    try {
      final byteData = await rootBundle.load('assets/$assetPath');
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$localFileName');
      
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
      return file;
    } catch (e) {
      throw Exception('Không thể copy file $assetPath: $e');
    }
  }
  
  // Get list of files in assets directory (dùng cho development)
  static Future<List<String>> getAssetFiles(String directory) async {
    try {
      final manifest = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = jsonDecode(manifest);
      
      return manifestMap.keys
          .where((key) => key.startsWith(directory))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  // Load và cache image
  static Future<ImageProvider> loadImage(String imagePath) async {
    return AssetImage(getAssetPath(imagePath));
  }
  
  // Parse JSON từ string
  static dynamic parseJsonString(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      throw Exception('JSON không hợp lệ: $e');
    }
  }
  
  // Convert data to JSON string
  static String toJsonString(dynamic data) {
    return jsonEncode(data);
  }
  
  // Pretty print JSON
  static String prettyJson(dynamic data) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }
  
  // Load và validate JSON schema
  static Future<bool> validateJsonSchema(
    String jsonFileName,
    List<String> requiredFields,
  ) async {
    try {
      final data = await loadJsonMap(jsonFileName);
      
      for (var field in requiredFields) {
        if (!data.containsKey(field)) {
          return false;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Merge multiple JSON files
  static Future<Map<String, dynamic>> mergeJsonFiles(
    List<String> jsonFiles,
  ) async {
    final result = <String, dynamic>{};
    
    for (var file in jsonFiles) {
      try {
        final data = await loadJsonMap(file);
        result.addAll(data);
      } catch (e) {
        // Bỏ qua file lỗi
      }
    }
    
    return result;
  }
}

// Extension cho String để parse JSON dễ dàng
extension JsonExtension on String {
  dynamic toJson() {
    return AssetUtil.parseJsonString(this);
  }
}

// Extension cho Map/List để convert sang JSON string
extension JsonStringExtension on dynamic {
  String toJsonString() {
    return AssetUtil.toJsonString(this);
  }
}