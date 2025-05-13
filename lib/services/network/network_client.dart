import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../storage/secure_storage.dart';

class NetworkClient {
  NetworkClient({required SecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  final _headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.toString(),
    HttpHeaders.acceptHeader: ContentType.json.toString(),
  };

  final _client = http.Client();

  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) async {
    if ((headers ?? const {})[HttpHeaders.authorizationHeader] == null) {
      _secure((await _secureStorage.getSessionId()));
    }

    // final requestHeaders = _headers;
    // if (headers?.isNotEmpty == true) {
    //   requestHeaders.addAll(headers ?? {});
    // }

    final response = await _client.get(uri);

    return response;
  }

  Future<http.Response> patch(
    Uri uri, {
    String? body,
    Map<String, String>? headers,
  }) async {
    if ((headers ?? const {})[HttpHeaders.authorizationHeader] == null) {
      _secure((await _secureStorage.getSessionId()));
    }

    final requestHeaders = _headers;
    requestHeaders.addAll(headers ?? {});

    final response = await _client.patch(
      uri,
      headers: requestHeaders,
      body: body,
    );
    return response;
  }

  Future<http.Response> delete(
    Uri uri, {
    String? body,
    Map<String, String>? headers,
  }) async {
    if ((headers ?? const {})[HttpHeaders.authorizationHeader] == null) {
      _secure((await _secureStorage.getSessionId()));
    }

    final requestHeaders = _headers;
    requestHeaders.addAll(headers ?? {});

    final response = await _client.delete(
      uri,
      headers: requestHeaders,
      body: body,
    );

    return response;
  }

  Future<http.Response> post(
    Uri uri, {
    String? body,
    Map<String, String>? headers,
  }) async {
    if ((headers ?? const {})[HttpHeaders.authorizationHeader] == null) {
      _secure((await _secureStorage.getSessionId()));
    }

    final requestHeaders = _headers;
    requestHeaders.addAll(headers ?? {});

    final response = await _client.post(
      uri,
      headers: requestHeaders,
      body: body,
    );

    return response;
  }

  void _secure(String? sessionId) {
    if (sessionId?.isNotEmpty == true) {
      _headers[HttpHeaders.authorizationHeader] = '$sessionId';
    }
  }
}
