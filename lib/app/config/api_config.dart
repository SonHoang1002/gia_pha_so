import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiConfig {
  static const String BASE_URL = "http://localhost:8080";
  static const Duration timeout = Duration(seconds: 30);
  
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  // Default headers
  Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-App-Version': '1.0.0',
  };
  
  // Get headers with authorization if token exists
  Future<Map<String, String>> _getHeaders({Map<String, String>? customHeaders}) async {
    final headers = Map<String, String>.from(defaultHeaders);
    
    // Add authorization token if exists
    final token = await _storage.read(key: 'auth_token');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    // Add custom headers if provided
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    
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
  Future<http.Response> get(
    String route, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    final url = _buildUrl(route, queryParams);
    final requestHeaders = await _getHeaders(customHeaders: headers);
    
    return http.get(
      url,
      headers: requestHeaders,
    ).timeout(timeout);
  }
  
  // POST request
  Future<http.Response> post(
    String route,
    Object? body, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);
    
    return http.post(
      Uri.parse(BASE_URL + route),
      headers: requestHeaders,
      body: body,
    ).timeout(timeout);
  }
  
  // PUT request
  Future<http.Response> put(
    String route,
    Object? body, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);
    
    return http.put(
      Uri.parse(BASE_URL + route),
      headers: requestHeaders,
      body: body,
    ).timeout(timeout);
  }
  
  // PATCH request
  Future<http.Response> patch(
    String route,
    Object? body, {
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);
    
    return http.patch(
      Uri.parse(BASE_URL + route),
      headers: requestHeaders,
      body: body,
    ).timeout(timeout);
  }
  
  // DELETE request
  Future<http.Response> delete(
    String route, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final requestHeaders = await _getHeaders(customHeaders: headers);
    
    return http.delete(
      Uri.parse(BASE_URL + route),
      headers: requestHeaders,
      body: body,
    ).timeout(timeout);
  }
  
  // Multipart file upload
  Future<http.Response> uploadFile(
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
  Uri _buildUrl(String route, Map<String, dynamic>? queryParams) {
    final url = Uri.parse(BASE_URL + route);
    
    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = Uri(queryParameters: queryParams).query;
      return Uri.parse('$url?$queryString');
    }
    
    return url;
  }
}