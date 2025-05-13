import 'package:petshopdashboard/services/storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  NetworkClient({
    required SecureStorage secureStorage,
    required http.Client client,
  }) : _secureStorage = secureStorage,
       _client = client;

  final SecureStorage _secureStorage;

  final http.Client _client;

  Future<http.Response> put(
    Uri uri, {
    Map<String, String>? headers,
    String? body,
  }) async {
    final response = await _client.put(uri, headers: {}, body: body);

    return response;
  }

  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) async {
    final response = await _client.put(uri, headers: {});

    return response;
  }

  Future<http.Response> patch(
    Uri uri, {
    String? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client.put(uri, headers: {}, body: body);

    return response;
  }

  Future<http.Response> post(
    Uri uri, {
    String? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client.put(uri, headers: {}, body: body);

    return response;
  }
}
