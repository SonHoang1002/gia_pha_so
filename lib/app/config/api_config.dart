import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  static const String BASE_URL = "http://192.168.1.214:8080";
  static const Duration timeout = Duration(seconds: 30);

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Default headers
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
  };

  // Get headers with authorization if token exists
  static Future<Map<String, String>> _getHeaders({
    Map<String, String>? customHeaders,
  }) async {
    final headers = Map<String, String>.from(defaultHeaders);

    // // Add authorization token if exists
    // final token = await _storage.read(key: 'auth_token');
    // if (token != null) {
    //   headers['Authorization'] = 'Bearer $token';
    // }

    // // Add custom headers if provided
    // if (customHeaders != null) {
    //   headers.addAll(customHeaders);
    // }

    return headers;
  }

  // Save token
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  // Remove token (logout)
  Future<void> removeToken() async {
    await _storage.delete(key: 'auth_token');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'auth_token');
    return token != null;
  }

  // GET request
  static Future<http.Response> get(
    String route, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    final url = _buildUrl(route, queryParams);
    final requestHeaders = await _getHeaders(customHeaders: headers);

    return http.get(url, headers: requestHeaders).timeout(timeout);
  }

  // POST request

  static Future<http.Response> post(
    String route,
    Object? body, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);

    // Mã hóa body thành JSON nếu nó không null
    final encodedBody = body != null ? jsonEncode(body) : null;

    return http
        .post(
          Uri.parse(BASE_URL + route),
          headers: requestHeaders,
          body: encodedBody,
        )
        .timeout(timeout);
  }

  // PUT request
  static Future<http.Response> put(
    String route,
    Object? body, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);

    return http
        .put(Uri.parse(BASE_URL + route), headers: requestHeaders, body: body)
        .timeout(timeout);
  }

  // PATCH request
  static Future<http.Response> patch(
    String route,
    Object? body, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);

    return http
        .patch(Uri.parse(BASE_URL + route), headers: requestHeaders, body: body)
        .timeout(timeout);
  }

  // DELETE request
  static Future<http.Response> delete(
    String route, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);

    return http
        .delete(
          Uri.parse(BASE_URL + route),
          headers: requestHeaders,
          body: body,
        )
        .timeout(timeout);
  }

  // Multipart file upload
  static Future<http.Response> uploadFile(
    String route,
    String filePath,
    String fieldName, {
    Map<String, String>? fields,
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);
    requestHeaders.remove('Content-Type'); // Remove for multipart

    final request = http.MultipartRequest('POST', Uri.parse(BASE_URL + route));
    request.headers.addAll(requestHeaders);

    // Add file
    request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));

    // Add additional fields
    if (fields != null) {
      request.fields.addAll(fields);
    }

    final streamedResponse = await request.send().timeout(timeout);
    return http.Response.fromStream(streamedResponse);
  }

  // Helper method to build URL with query parameters
  static Uri _buildUrl(String route, Map<String, dynamic>? queryParams) {
    final url = Uri.parse(BASE_URL + route);

    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = Uri(queryParameters: queryParams).query;
      return Uri.parse('$url?$queryString');
    }

    return url;
  }
}
