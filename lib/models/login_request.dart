import 'dart:convert';

import 'package:petshopdashboard/models/network_request.dart';

class LoginRequest extends NetworkRequest {
  LoginRequest({
    required super.url,
    required String email,
    required String password,
  }) : _email = email,
       _password = password;

  final String _email;
  final String _password;

  @override
  String? get body => json.encode({'email': _email, 'password': _password});
}
